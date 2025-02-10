import 'package:watchflix/features/sources/domain/models/source_category.dart';
import 'package:watchflix/features/sources/domain/repositories/i_sources_repository.dart';

class GetSourcesUseCase {
  const GetSourcesUseCase(this.repository);
  final ISourcesRepository repository;

  Future<CategoryizedSources> execute() {
    return repository.getSources();
  }
}
