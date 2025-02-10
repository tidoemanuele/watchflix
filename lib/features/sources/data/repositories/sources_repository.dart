import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/cache/cache_config.dart';
import 'package:watchflix/core/cache/cache_entry.dart';
import 'package:watchflix/core/services/watchmode_service.dart';
import 'package:watchflix/features/sources/domain/models/source_category.dart';
import 'package:watchflix/features/sources/domain/repositories/i_sources_repository.dart';

class SourcesRepository implements ISourcesRepository {
  const SourcesRepository(this._watchmodeService);
  final WatchmodeService _watchmodeService;
  final _cache = const _SourcesCache();

  @override
  Future<CategoryizedSources> getSources() async {
    final cachedSources = _cache.getSources();
    if (cachedSources != null) {
      return cachedSources;
    }

    try {
      final sources = await _watchmodeService.getSources();
      final categorizedSources = CategoryizedSources.fromSourcesList(sources);
      _cache.setSources(categorizedSources);
      return categorizedSources;
    } catch (e) {
      throw Exception('Failed to load sources: $e');
    }
  }

  void clearCache() => _cache.clear();

  SourceSummary? _findSourceInCategories(
    CategoryizedSources sources,
    int sourceId,
  ) {
    final allSources = [
      ...sources.subscriptionSources,
      ...sources.freeSources,
      ...sources.purchaseSources,
      ...sources.tvChannelSources,
      ...sources.otherSources,
    ];
    return allSources.where((source) => source.id == sourceId).firstOrNull;
  }
}

class _SourcesCache {
  const _SourcesCache();

  static final _sourcesCache = <CacheEntry<CategoryizedSources>>[];

  CategoryizedSources? getSources() {
    if (_sourcesCache.isEmpty) {
      return null;
    }
    final entry = _sourcesCache.first;
    if (entry.isExpired) {
      _sourcesCache.clear();
      return null;
    }
    return entry.data;
  }

  void setSources(CategoryizedSources sources) {
    _sourcesCache..clear()
    ..add(
      CacheEntry(
        data: sources,
        timestamp: DateTime.now(),
        expirationDuration: CacheConfig.defaultExpiration,
      ),
    );
  }


  void clear() {
    _sourcesCache.clear();
  }
}
