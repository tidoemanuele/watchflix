import 'package:watchflix/features/list_titles/domain/models/title_item.dart';
import 'package:watchflix/features/list_titles/domain/repositories/i_titles_repository.dart';

class GetTitlesUseCase {
  const GetTitlesUseCase(this.repository);
  final ITitlesRepository repository;

  Future<(List<TitleItem>, int)> execute({
    required String sourceIds,
    required int page,
    required int limit,
  }) {
    return repository.getTitles(
      sourceIds: sourceIds,
      page: page,
      limit: limit,
    );
  }
}
