import 'package:leancode_cubit_utils/leancode_cubit_utils.dart';
import 'package:watchflix/api/gen/watchmode_api.enums.swagger.dart';
import 'package:watchflix/features/list_titles/domain/models/title_item.dart';
import 'package:watchflix/features/list_titles/domain/usecases/get_titles_usecase.dart';

class TitlesCubit
    extends PaginatedCubit<void, List<TitleItem>, List<TitleItem>, TitleItem> {
  TitlesCubit({
    required this.getTitlesUseCase,
    required this.sourceIds,
    this.filterType,
  }) : super(
          config: PaginatedConfig(),
          loggerTag: 'TitlesCubit',
        );

  final GetTitlesUseCase getTitlesUseCase;
  final String sourceIds;
  final TitleType? filterType;
  int? _totalPages;

  @override
  Future<List<TitleItem>> requestPage(PaginatedArgs args) async {
    final result = await getTitlesUseCase.execute(
      sourceIds: sourceIds,
      page: args.pageNumber + 1,
      limit: args.pageSize,
    );
    _totalPages = result.$2;
    return result.$1;
  }

  @override
  RequestResult<List<TitleItem>> handleResponse(List<TitleItem> res) {
    if (_totalPages == 0) {
      return const Failure<List<TitleItem>>(
        'No titles found for the selected streaming service',
      );
    }
    return Success(res);
  }

  @override
  PaginatedResponse<void, TitleItem> onPageResult(List<TitleItem> page) {
    final currentPage = state.args.pageNumber + 1;
    // Handle case when there are no results (total_pages = 0)
    if (_totalPages == 0) {
      return PaginatedResponse.append(
        items: [],
        hasNextPage: false,
      );
    }
    return PaginatedResponse.append(
      items: page,
      hasNextPage: _totalPages != null && currentPage < _totalPages!,
    );
  }
}
