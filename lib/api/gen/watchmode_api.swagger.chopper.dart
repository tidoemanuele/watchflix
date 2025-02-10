// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchmode_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WatchmodeApi extends WatchmodeApi {
  _$WatchmodeApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WatchmodeApi;

  @override
  Future<Response<List<SourceSummary>>> _sourcesGet() {
    final Uri $url = Uri.parse('/sources/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SourceSummary>, SourceSummary>($request);
  }

  @override
  Future<Response<TitleDetails>> _titleTitleIdDetailsGet(
      {required int? titleId}) {
    final Uri $url = Uri.parse('/title/${titleId}/details/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TitleDetails, TitleDetails>($request);
  }

  @override
  Future<Response<TitlesResult>> _listTitlesGet({
    required String? sourceIds,
    required int? limit,
    required int? page,
  }) {
    final Uri $url = Uri.parse('/list-titles/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'source_ids': sourceIds,
      'limit': limit,
      'page': page,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TitlesResult, TitlesResult>($request);
  }
}
