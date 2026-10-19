/// Entidade de domínio representando uma música salva no dispositivo.
class Song {
  final int id;
  final String title;
  final String artist;
  final String fullLyrics;
  final DateTime createdAt;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.fullLyrics,
    required this.createdAt,
  });
}

/// Seção identificada da música (ex: Estrofe 1, Refrão, etc.)
class SongSection {
  final int id;
  final int songId;
  final int sectionOrder;
  final String label;
  final String textContent;

  const SongSection({
    required this.id,
    required this.songId,
    required this.sectionOrder,
    required this.label,
    required this.textContent,
  });
}
