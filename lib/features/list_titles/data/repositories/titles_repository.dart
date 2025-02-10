import 'package:watchflix/core/cache/cache_config.dart';
import 'package:watchflix/core/cache/cache_entry.dart';
import 'package:watchflix/core/services/watchmode_service.dart';
import 'package:watchflix/features/list_titles/domain/models/title_item.dart';
import 'package:watchflix/features/list_titles/domain/repositories/i_titles_repository.dart';

class TitlesRepository implements ITitlesRepository {
  const TitlesRepository(this._watchmodeService);

  final WatchmodeService _watchmodeService;
  final _cache = const _TitlesCache();

  @override
  Future<(List<TitleItem>, int)> getTitles({
    required String sourceIds,
    int page = 1,
    int limit = 20,
  }) async {
    final cacheKey = '$sourceIds-$page';
    final cachedData = _cache.get(cacheKey);
    if (cachedData != null) {
      return cachedData;
    }

    final result = await _watchmodeService.getListTitles(
      sourceIds: sourceIds,
      page: page,
      limit: limit,
    );

    final titles = result.titles.map(TitleItem.fromTitleSummary).toList()
      ..sort((a, b) => (b.year ?? 0).compareTo(a.year ?? 0));

    final data = (titles, result.totalPages);
    _cache.set(cacheKey, data);

    return data;
  }

  void clearCache() => _cache.clear();
}

class _TitlesCache {
  const _TitlesCache();

  static final Map<String, CacheEntry<(List<TitleItem>, int)>> _cache = {};

  (List<TitleItem>, int)? get(String key) {
    final entry = _cache[key];
    if (entry == null || entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    return entry.data;
  }

  void set(String key, (List<TitleItem>, int) data) {
    _cleanCache();
    
    _cache[key] = CacheEntry(
      data: data,
      timestamp: DateTime.now(),
      expirationDuration: CacheConfig.defaultExpiration,
    );
  }

  void clear() => _cache.clear();

  void _cleanCache() {
    _cache.removeWhere((_, entry) => entry.isExpired);

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
