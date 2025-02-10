import '../../api/gen/watchmode_api.swagger.dart';
import '../../api/watchmode_api.dart';
import '../../app_config.dart';

class WatchmodeService {
  WatchmodeService(AppConfig config)
      : _api = createWatchmodeApi(
          baseUrl: config.watchmodeBaseUrl,
          apiKey: config.watchmodeApiKey,
        );
  final WatchmodeApi _api;

  Future<List<SourceSummary>> getSources() async {
    try {
      final response = await _api.sourcesGet();
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      throw Exception('Failed to load sources: Status code ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load sources: $e. Please check your internet connection and API key.');
    }
  }

  Future<TitlesResult> getListTitles({
    required String sourceIds,
    int limit = 20,
    int page = 1,
  }) async {
    final response = await _api.listTitlesGet(
      sourceIds: sourceIds,
      limit: limit,
      page: page,
    );
    if (response.isSuccessful && response.body != null) {
      return response.body!;
    }
    throw Exception('Failed to load titles');
  }

  Future<TitleDetails> getTitleDetails(int titleId) async {
    final response = await _api.titleTitleIdDetailsGet(titleId: titleId);
    if (response.isSuccessful && response.body != null) {
      return response.body!;
    }
    throw Exception('Failed to load title details');
  }
}
