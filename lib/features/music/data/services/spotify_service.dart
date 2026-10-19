import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final spotifyServiceProvider = Provider<SpotifyService>((ref) {
  return SpotifyService();
});

class SpotifyTrackInfo {
  final String title;
  final String artist;
  final String? thumbnailUrl;

  const SpotifyTrackInfo({
    required this.title,
    required this.artist,
    this.thumbnailUrl,
  });
}

class SpotifyService {
  final Dio _dio = Dio();

  static final _trackRegex = RegExp(r'open\.spotify\.com/track/([a-zA-Z0-9]+)');
  static final _playlistRegex = RegExp(r'open\.spotify\.com/playlist/([a-zA-Z0-9]+)');

  bool isSpotifyUrl(String url) {
    return _trackRegex.hasMatch(url) || _playlistRegex.hasMatch(url);
  }

  bool isTrackUrl(String url) => _trackRegex.hasMatch(url);
  bool isPlaylistUrl(String url) => _playlistRegex.hasMatch(url);

  Future<SpotifyTrackInfo?> getTrackInfo(String url) async {
    try {
      final response = await _dio.get(
        'https://open.spotify.com/oembed',
        queryParameters: {'url': url},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final fullTitle = data['title'] as String? ?? '';

        // oEmbed returns "Title by Artist"
        final parts = fullTitle.split(' by ');
        final title = parts.isNotEmpty ? parts.first.trim() : fullTitle;
        final artist = parts.length > 1 ? parts.sublist(1).join(' by ').trim() : '';

        return SpotifyTrackInfo(
          title: title,
          artist: artist,
          thumbnailUrl: data['thumbnail_url'] as String?,
        );
      }
    } catch (_) {}
    return null;
  }

  Future<List<SpotifyTrackInfo>> getPlaylistTracks(String url) async {
    // oEmbed only returns playlist name, not individual tracks.
    // For full track listing, Spotify Web API with OAuth is needed.
    // Return the playlist info as a single entry for now.
    try {
      final response = await _dio.get(
        'https://open.spotify.com/oembed',
        queryParameters: {'url': url},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return [
          SpotifyTrackInfo(
            title: data['title'] as String? ?? 'Playlist',
            artist: 'Spotify Playlist',
            thumbnailUrl: data['thumbnail_url'] as String?,
          ),
        ];
      }
    } catch (_) {}
    return [];
  }
}
