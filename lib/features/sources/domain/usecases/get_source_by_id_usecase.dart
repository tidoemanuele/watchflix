import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/features/sources/domain/repositories/i_sources_repository.dart';

class GetSourceByIdUseCase {
  const GetSourceByIdUseCase(this.repository);
  final ISourcesRepository repository;

  Future<SourceSummary> execute(int sourceId) {
    return repository.getSourceById(sourceId);
  }
}
