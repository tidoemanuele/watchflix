import 'package:watchflix/api/gen/watchmode_api.swagger.dart';

enum SourceCategory {
  subscription,
  free,
  purchase,
  tvChannels,
  others;

  String get displayName {
    switch (this) {
      case SourceCategory.subscription:
        return 'Subscription Services';
      case SourceCategory.free:
        return 'Free Services';
      case SourceCategory.purchase:
        return 'Purchase Options';
      case SourceCategory.tvChannels:
        return 'TV Channels';
      case SourceCategory.others:
        return 'Others';
    }
  }
}

class CategoryizedSources {
  const CategoryizedSources({
    required this.subscriptionSources,
    required this.freeSources,
    required this.purchaseSources,
    required this.tvChannelSources,
    required this.otherSources,
  });

  factory CategoryizedSources.fromSourcesList(List<SourceSummary> sources) {
    return CategoryizedSources(
      subscriptionSources:
          sources.where((source) => source.type == SourceType.sub).toList(),
      freeSources:
          sources.where((source) => source.type == SourceType.free).toList(),
      purchaseSources: sources
          .where((source) => source.type == SourceType.purchase)
          .toList(),
      tvChannelSources:
          sources.where((source) => source.type == SourceType.tve).toList(),
      otherSources: sources
          .where((source) => source.type == SourceType.swaggerGeneratedUnknown)
          .toList(),
    );
  }

  final List<SourceSummary> subscriptionSources;
  final List<SourceSummary> freeSources;
  final List<SourceSummary> purchaseSources;
  final List<SourceSummary> tvChannelSources;
  final List<SourceSummary> otherSources;
}
