import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/features/sources/domain/models/source_category.dart';

abstract class ISourcesRepository {
  Future<CategoryizedSources> getSources();
  Future<SourceSummary> getSourceById(int sourceId);
}
