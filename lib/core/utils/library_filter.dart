bool isPodcastPath(String? path) {
  if (path == null) return false;
  final normalized = path.replaceAll('\\', '/').toLowerCase();
  final segments = normalized.split('/');
  // ignora o nome do arquivo, olha só as pastas
  final directories = segments.length > 1
      ? segments.sublist(0, segments.length - 1)
      : segments;
  return directories.any((segment) => segment.contains('casts'));
}
