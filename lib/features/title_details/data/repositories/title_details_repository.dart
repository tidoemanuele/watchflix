import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/cache/cache_config.dart';
import 'package:watchflix/core/cache/cache_entry.dart';
import 'package:watchflix/core/services/watchmode_service.dart';
import 'package:watchflix/features/title_details/domain/repositories/i_title_details_repository.dart';

class TitleDetailsRepository implements ITitleDetailsRepository {
  const TitleDetailsRepository(this._watchmodeService);
  final WatchmodeService _watchmodeService;
  final _cache = const _TitleDetailsCache();

  @override
  Future<TitleDetails> getTitleDetails(int titleId) async {
    final cachedDetails = _cache.get(titleId);
    if (cachedDetails != null) {
      return cachedDetails;
    }

    try {
      final details = await _watchmodeService.getTitleDetails(titleId);
      _cache.set(titleId, details);
      return details;
    } catch (e) {
      throw Exception('Failed to load title details: $e');
    }
  }

  void clearCache() => _cache.clear();
}

class _TitleDetailsCache {
  const _TitleDetailsCache();

  static final Map<int, CacheEntry<TitleDetails>> _cache = {};

  TitleDetails? get(int titleId) {
    final entry = _cache[titleId];
    if (entry == null || entry.isExpired) {
      _cache.remove(titleId);
      return null;
    }
    return entry.data;
  }

  void set(int titleId, TitleDetails data) {
    _cleanCache();
    
    _cache[titleId] = CacheEntry(
      data: data,
      timestamp: DateTime.now(),
      expirationDuration: CacheConfig.defaultExpiration,
    );
  }

  void clear() => _cache.clear();

  void _cleanCache() {
    // Remove expired entries
    _cache.removeWhere((_, entry) => entry.isExpired);

    // Remove oldest entries if cache size exceeds limit
    if (_cache.length >= CacheConfig.maxCacheSize) {
      final sortedEntries = _cache.entries.toList()
        ..sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));
      
      final entriesToRemove = sortedEntries.take(
        (_cache.length - CacheConfig.maxCacheSize) + 1,
      );
      
      for (final entry in entriesToRemove) {
        _cache.remove(entry.key);
      }
    }
  }
}
