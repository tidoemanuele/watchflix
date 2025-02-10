import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';

abstract class ITitleDetailsRepository {
  Future<TitleDetails> getTitleDetails(int titleId);
}
