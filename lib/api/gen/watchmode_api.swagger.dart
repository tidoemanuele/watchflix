// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'watchmode_api.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'watchmode_api.enums.swagger.dart' as enums;
export 'watchmode_api.enums.swagger.dart';
export 'watchmode_api.models.swagger.dart';

part 'watchmode_api.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class WatchmodeApi extends ChopperService {
  static WatchmodeApi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$WatchmodeApi(client);
    }

    final newClient = ChopperClient(
        services: [_$WatchmodeApi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl);
    return _$WatchmodeApi(newClient);
  }

  ///Retrieve a list of streaming sources
  Future<chopper.Response<List<SourceSummary>>> sourcesGet() {
    generatedMapping.putIfAbsent(
        SourceSummary, () => SourceSummary.fromJsonFactory);

    return _sourcesGet();
  }

  ///Retrieve a list of streaming sources
  @Get(path: '/sources/')
  Future<chopper.Response<List<SourceSummary>>> _sourcesGet();

  ///Retrieve Title Details
  ///@param title_id The unique ID of the title
  Future<chopper.Response<TitleDetails>> titleTitleIdDetailsGet(
      {required int? titleId}) {
    generatedMapping.putIfAbsent(
        TitleDetails, () => TitleDetails.fromJsonFactory);

    return _titleTitleIdDetailsGet(titleId: titleId);
  }

  ///Retrieve Title Details
  ///@param title_id The unique ID of the title
  @Get(path: '/title/{title_id}/details/')
  Future<chopper.Response<TitleDetails>> _titleTitleIdDetailsGet(
      {@Path('title_id') required int? titleId});

  ///List Titles
  ///@param source_ids A comma-separated list of source IDs to filter by
  ///@param limit Maximum number of titles to return (default is 10)
  ///@param page The page number for paginated results (default is 1)
  Future<chopper.Response<TitlesResult>> listTitlesGet({
    required String? sourceIds,
    required int? limit,
    required int? page,
  }) {
    generatedMapping.putIfAbsent(
        TitlesResult, () => TitlesResult.fromJsonFactory);

    return _listTitlesGet(sourceIds: sourceIds, limit: limit, page: page);
  }

  ///List Titles
  ///@param source_ids A comma-separated list of source IDs to filter by
  ///@param limit Maximum number of titles to return (default is 10)
  ///@param page The page number for paginated results (default is 1)
  @Get(path: '/list-titles/')
  Future<chopper.Response<TitlesResult>> _listTitlesGet({
    @Query('source_ids') required String? sourceIds,
    @Query('limit') required int? limit,
    @Query('page') required int? page,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
