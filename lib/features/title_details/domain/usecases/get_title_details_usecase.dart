import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/features/title_details/domain/repositories/i_title_details_repository.dart';

class GetTitleDetailsUseCase {
  GetTitleDetailsUseCase(this.repository);
  final ITitleDetailsRepository repository;

  Future<TitleDetails> execute(int titleId) {
    return repository.getTitleDetails(titleId);
  }
}
