import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/utils/result.dart';
import 'package:watchflix/features/sources/domain/models/source_category.dart';
import 'package:watchflix/features/sources/domain/usecases/get_source_by_id_usecase.dart';
import 'package:watchflix/features/sources/domain/usecases/get_sources_usecase.dart';

class SourcesCubit extends Cubit<Result<CategoryizedSources>> {
  SourcesCubit({
    required this.getSourcesUseCase,
    required this.getSourceByIdUseCase,
  }) : super(const Loading());

  final GetSourcesUseCase getSourcesUseCase;
  final GetSourceByIdUseCase getSourceByIdUseCase;

  Future<void> load() async {
    emit(const Loading());
    try {
      final sources = await getSourcesUseCase.execute();
      emit(Success(sources));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<SourceSummary?> getSourceById(int sourceId) async {
    try {
      return await getSourceByIdUseCase.execute(sourceId);
    } catch (e) {
      return null;
    }
  }
}
