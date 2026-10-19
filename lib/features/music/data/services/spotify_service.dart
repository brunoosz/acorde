import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/secure_storage_service.dart';

final spotifyServiceProvider = Provider<SpotifyService>((ref) {
  final storage = ref.watch(secureStorageServiceProvider);
  return SpotifyService(storage);
});

class SpotifyTrackInfo {
  final String trackId;
  final String title;
  final String artist;
  final String? thumbnailUrl;
  final String? previewUrl;

  const SpotifyTrackInfo({
    required this.trackId,
    required this.title,
    required this.artist,
    this.thumbnailUrl,
    this.previewUrl,
  });
}

class SpotifyService {
  final SecureStorageService _storage;
  final Dio _dio = Dio();

  static final _trackRegex = RegExp(r'open\.spotify\.com/track/([a-zA-Z0-9]+)');
  static final _playlistRegex = RegExp(r'open\.spotify\.com/playlist/([a-zA-Z0-9]+)');

  SpotifyService(this._storage);

  bool isSpotifyUrl(String url) {
    return _trackRegex.hasMatch(url) || _playlistRegex.hasMatch(url);
  }

  bool isTrackUrl(String url) => _trackRegex.hasMatch(url);
  bool isPlaylistUrl(String url) => _playlistRegex.hasMatch(url);

  String? _extractId(String url, RegExp regex) {
    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  Future<bool> get isConfigured => _storage.hasSpotifyCredentials();

  /// Authenticate using Client Credentials flow (no user login)
  Future<String?> _getAccessToken() async {
    final cached = await _storage.getSpotifyAccessToken();
    if (cached != null) return cached;

    final clientId = await _storage.getSpotifyClientId();
    final clientSecret = await _storage.getSpotifyClientSecret();
    if (clientId == null || clientSecret == null || clientId.isEmpty || clientSecret.isEmpty) {
      return null;
    }

    try {
      final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
      final response = await _dio.post(
        'https://accounts.spotify.com/api/token',
        data: 'grant_type=client_credentials',
        options: Options(
          headers: {
            'Authorization': 'Basic $credentials',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'] as String;
        final expiresIn = response.data['expires_in'] as int;
        await _storage.setSpotifyAccessToken(token, Duration(seconds: expiresIn - 60));
        return token;
      }
    } catch (_) {}
    return null;
  }

  /// Get track info from a Spotify URL (tries API first, falls back to oEmbed)
  Future<SpotifyTrackInfo?> getTrackInfo(String url) async {
    final trackId = _extractId(url, _trackRegex);

    // Try authenticated API first
    final token = await _getAccessToken();
    if (token != null && trackId != null) {
      try {
        final response = await _dio.get(
          'https://api.spotify.com/v1/tracks/$trackId',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          final artists = (data['artists'] as List?)
                  ?.map((a) => a['name'] as String)
                  .join(', ') ??
              '';
          final images = data['album']?['images'] as List?;
          return SpotifyTrackInfo(
            trackId: trackId,
            title: data['name'] as String? ?? '',
            artist: artists,
            thumbnailUrl: images?.isNotEmpty == true ? images!.first['url'] as String? : null,
            previewUrl: data['preview_url'] as String?,
          );
        }
      } catch (_) {}
    }

    // Fallback to oEmbed (no auth needed)
    return _getTrackInfoOembed(url);
  }

  Future<SpotifyTrackInfo?> _getTrackInfoOembed(String url) async {
    try {
      final response = await _dio.get(
        'https://open.spotify.com/oembed',
        queryParameters: {'url': url},
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final fullTitle = data['title'] as String? ?? '';
        final parts = fullTitle.split(' by ');
        final title = parts.isNotEmpty ? parts.first.trim() : fullTitle;
        final artist = parts.length > 1 ? parts.sublist(1).join(' by ').trim() : '';
        return SpotifyTrackInfo(
          trackId: '',
          title: title,
          artist: artist,
          thumbnailUrl: data['thumbnail_url'] as String?,
        );
      }
    } catch (_) {}
    return null;
  }

  /// Get all tracks from a playlist
  Future<List<SpotifyTrackInfo>> getPlaylistTracks(String url) async {
    final playlistId = _extractId(url, _playlistRegex);
    if (playlistId == null) return [];

    final token = await _getAccessToken();
    if (token == null) return [];

    final tracks = <SpotifyTrackInfo>[];
    String? nextUrl = 'https://api.spotify.com/v1/playlists/$playlistId/tracks?limit=50';

    try {
      while (nextUrl != null) {
        final response = await _dio.get(
          nextUrl,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode != 200) break;

        final data = response.data as Map<String, dynamic>;
        final items = data['items'] as List? ?? [];

        for (final item in items) {
          final track = item['track'] as Map<String, dynamic>?;
          if (track == null) continue;

          final artists = (track['artists'] as List?)
                  ?.map((a) => a['name'] as String)
                  .join(', ') ??
              '';
          final images = track['album']?['images'] as List?;

          tracks.add(SpotifyTrackInfo(
            trackId: track['id'] as String? ?? '',
            title: track['name'] as String? ?? '',
            artist: artists,
            thumbnailUrl: images?.isNotEmpty == true ? images!.first['url'] as String? : null,
            previewUrl: track['preview_url'] as String?,
          ));
        }

        nextUrl = data['next'] as String?;
      }
    } catch (_) {}

    return tracks;
  }

  /// Search tracks by query
  Future<List<SpotifyTrackInfo>> searchTracks(String query, {int limit = 10}) async {
    final token = await _getAccessToken();
    if (token == null) return [];

    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/search',
        queryParameters: {
          'q': query,
          'type': 'track',
          'limit': limit,
          'market': 'AR',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final items = response.data['tracks']?['items'] as List? ?? [];
        return items.map((track) {
          final artists = (track['artists'] as List?)
                  ?.map((a) => a['name'] as String)
                  .join(', ') ??
              '';
          final images = track['album']?['images'] as List?;
          return SpotifyTrackInfo(
            trackId: track['id'] as String? ?? '',
            title: track['name'] as String? ?? '',
            artist: artists,
            thumbnailUrl: images?.isNotEmpty == true ? images!.first['url'] as String? : null,
            previewUrl: track['preview_url'] as String?,
          );
        }).toList();
      }
    } catch (_) {}
    return [];
  }
}
