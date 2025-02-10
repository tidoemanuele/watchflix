import 'package:watchflix/features/list_titles/domain/models/title_item.dart';

abstract class ITitlesRepository {
  Future<(List<TitleItem>, int)> getTitles({
    required String sourceIds,
    int page = 1,
    int limit = 20,
  });
}
