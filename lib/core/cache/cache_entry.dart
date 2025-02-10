class CacheEntry<T> {
  const CacheEntry({
    required this.data,
    required this.timestamp,
    required this.expirationDuration,
  });

  final T data;
  final DateTime timestamp;
  final Duration expirationDuration;

  bool get isExpired =>
      DateTime.now().difference(timestamp) > expirationDuration;
}
