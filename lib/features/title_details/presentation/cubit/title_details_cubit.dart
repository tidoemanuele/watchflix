import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/utils/result.dart';
import 'package:watchflix/features/title_details/domain/usecases/get_title_details_usecase.dart';

class TitleDetailsCubit extends Cubit<Result<TitleDetails>> {
  TitleDetailsCubit(this._getTitleDetailsUseCase) : super(const Loading());

  final GetTitleDetailsUseCase _getTitleDetailsUseCase;
  StreamSubscription<TitleDetails>? _detailsSubscription;

  Future<void> loadDetails(int titleId) async {
    emit(const Loading());
    try {
      await _detailsSubscription?.cancel();
      final details = await _getTitleDetailsUseCase.execute(titleId);
      emit(Success(details));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _detailsSubscription?.cancel();
    return super.close();
  }
}
