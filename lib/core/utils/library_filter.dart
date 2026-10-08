/// Substrings que marcam um diretório como de podcasts. A checagem é feita
/// em minúsculas, então funciona de forma case insensitive.
const List<String> _podcastDirectoryMarkers = ['pod', 'cast'];

bool isPodcastPath(String? path) {
  if (path == null) return false;
  final normalized = path.replaceAll('\\', '/').toLowerCase();
  final segments = normalized.split('/');
  // ignora o nome do arquivo, olha só as pastas
  final directories = segments.length > 1
      ? segments.sublist(0, segments.length - 1)
      : segments;
  return directories.any(
    (segment) =>
        _podcastDirectoryMarkers.any((marker) => segment.contains(marker)),
  );
}
