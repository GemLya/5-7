class CachePolitica {
  final Duration ttl;
  const CachePolitica({this.ttl = const Duration(minutes: 15)});

  bool esValido(DateTime timestamp) {
    final ahora = DateTime.now();
    return ahora.difference(timestamp) < ttl;
  }
}