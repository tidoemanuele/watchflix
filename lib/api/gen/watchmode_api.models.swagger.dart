// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'watchmode_api.enums.swagger.dart' as enums;

part 'watchmode_api.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class SourceSummary {
  const SourceSummary({
    required this.id,
    required this.name,
    required this.type,
    required this.logo100px,
    required this.regions,
  });

  factory SourceSummary.fromJson(Map<String, dynamic> json) =>
      _$SourceSummaryFromJson(json);

  static const toJsonFactory = _$SourceSummaryToJson;
  Map<String, dynamic> toJson() => _$SourceSummaryToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'type',
    toJson: sourceTypeToJson,
    fromJson: sourceTypeFromJson,
  )
  final enums.SourceType type;
  @JsonKey(name: 'logo_100px')
  final String logo100px;
  @JsonKey(name: 'regions', defaultValue: <String>[])
  final List<String> regions;
  static const fromJsonFactory = _$SourceSummaryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SourceSummary &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.logo100px, logo100px) ||
                const DeepCollectionEquality()
                    .equals(other.logo100px, logo100px)) &&
            (identical(other.regions, regions) ||
                const DeepCollectionEquality().equals(other.regions, regions)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(logo100px) ^
      const DeepCollectionEquality().hash(regions) ^
      runtimeType.hashCode;
}

extension $SourceSummaryExtension on SourceSummary {
  SourceSummary copyWith(
      {int? id,
      String? name,
      enums.SourceType? type,
      String? logo100px,
      List<String>? regions}) {
    return SourceSummary(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        logo100px: logo100px ?? this.logo100px,
        regions: regions ?? this.regions);
  }

  SourceSummary copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? name,
      Wrapped<enums.SourceType>? type,
      Wrapped<String>? logo100px,
      Wrapped<List<String>>? regions}) {
    return SourceSummary(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        type: (type != null ? type.value : this.type),
        logo100px: (logo100px != null ? logo100px.value : this.logo100px),
        regions: (regions != null ? regions.value : this.regions));
  }
}

@JsonSerializable(explicitToJson: true)
class TitleSummary {
  const TitleSummary({
    required this.id,
    required this.title,
    required this.year,
    required this.type,
  });

  factory TitleSummary.fromJson(Map<String, dynamic> json) =>
      _$TitleSummaryFromJson(json);

  static const toJsonFactory = _$TitleSummaryToJson;
  Map<String, dynamic> toJson() => _$TitleSummaryToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'year')
  final int year;
  @JsonKey(
    name: 'type',
    toJson: titleTypeToJson,
    fromJson: titleTypeFromJson,
  )
  final enums.TitleType type;
  static const fromJsonFactory = _$TitleSummaryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TitleSummary &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $TitleSummaryExtension on TitleSummary {
  TitleSummary copyWith(
      {int? id, String? title, int? year, enums.TitleType? type}) {
    return TitleSummary(
        id: id ?? this.id,
        title: title ?? this.title,
        year: year ?? this.year,
        type: type ?? this.type);
  }

  TitleSummary copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? title,
      Wrapped<int>? year,
      Wrapped<enums.TitleType>? type}) {
    return TitleSummary(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        year: (year != null ? year.value : this.year),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class TitleDetails {
  const TitleDetails({
    required this.id,
    required this.title,
    required this.plotOverview,
    required this.type,
    required this.year,
    required this.genreNames,
    this.userRating,
    this.criticScore,
    required this.poster,
    this.backdrop,
    this.relevancePercentile,
  });

  factory TitleDetails.fromJson(Map<String, dynamic> json) =>
      _$TitleDetailsFromJson(json);

  static const toJsonFactory = _$TitleDetailsToJson;
  Map<String, dynamic> toJson() => _$TitleDetailsToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'plot_overview')
  final String plotOverview;
  @JsonKey(
    name: 'type',
    toJson: titleTypeToJson,
    fromJson: titleTypeFromJson,
  )
  final enums.TitleType type;
  @JsonKey(name: 'year')
  final int year;
  @JsonKey(name: 'genre_names', defaultValue: <String>[])
  final List<String> genreNames;
  @JsonKey(name: 'user_rating')
  final double? userRating;
  @JsonKey(name: 'critic_score')
  final int? criticScore;
  @JsonKey(name: 'poster')
  final String poster;
  @JsonKey(name: 'backdrop')
  final String? backdrop;
  @JsonKey(name: 'relevance_percentile')
  final double? relevancePercentile;
  static const fromJsonFactory = _$TitleDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TitleDetails &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.plotOverview, plotOverview) ||
                const DeepCollectionEquality()
                    .equals(other.plotOverview, plotOverview)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.genreNames, genreNames) ||
                const DeepCollectionEquality()
                    .equals(other.genreNames, genreNames)) &&
            (identical(other.userRating, userRating) ||
                const DeepCollectionEquality()
                    .equals(other.userRating, userRating)) &&
            (identical(other.criticScore, criticScore) ||
                const DeepCollectionEquality()
                    .equals(other.criticScore, criticScore)) &&
            (identical(other.poster, poster) ||
                const DeepCollectionEquality().equals(other.poster, poster)) &&
            (identical(other.backdrop, backdrop) ||
                const DeepCollectionEquality()
                    .equals(other.backdrop, backdrop)) &&
            (identical(other.relevancePercentile, relevancePercentile) ||
                const DeepCollectionEquality()
                    .equals(other.relevancePercentile, relevancePercentile)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(plotOverview) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(genreNames) ^
      const DeepCollectionEquality().hash(userRating) ^
      const DeepCollectionEquality().hash(criticScore) ^
      const DeepCollectionEquality().hash(poster) ^
      const DeepCollectionEquality().hash(backdrop) ^
      const DeepCollectionEquality().hash(relevancePercentile) ^
      runtimeType.hashCode;
}

extension $TitleDetailsExtension on TitleDetails {
  TitleDetails copyWith(
      {int? id,
      String? title,
      String? plotOverview,
      enums.TitleType? type,
      int? year,
      List<String>? genreNames,
      double? userRating,
      int? criticScore,
      String? poster,
      String? backdrop,
      double? relevancePercentile}) {
    return TitleDetails(
        id: id ?? this.id,
        title: title ?? this.title,
        plotOverview: plotOverview ?? this.plotOverview,
        type: type ?? this.type,
        year: year ?? this.year,
        genreNames: genreNames ?? this.genreNames,
        userRating: userRating ?? this.userRating,
        criticScore: criticScore ?? this.criticScore,
        poster: poster ?? this.poster,
        backdrop: backdrop ?? this.backdrop,
        relevancePercentile: relevancePercentile ?? this.relevancePercentile);
  }

  TitleDetails copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? title,
      Wrapped<String>? plotOverview,
      Wrapped<enums.TitleType>? type,
      Wrapped<int>? year,
      Wrapped<List<String>>? genreNames,
      Wrapped<double?>? userRating,
      Wrapped<int?>? criticScore,
      Wrapped<String>? poster,
      Wrapped<String?>? backdrop,
      Wrapped<double?>? relevancePercentile}) {
    return TitleDetails(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        plotOverview:
            (plotOverview != null ? plotOverview.value : this.plotOverview),
        type: (type != null ? type.value : this.type),
        year: (year != null ? year.value : this.year),
        genreNames: (genreNames != null ? genreNames.value : this.genreNames),
        userRating: (userRating != null ? userRating.value : this.userRating),
        criticScore:
            (criticScore != null ? criticScore.value : this.criticScore),
        poster: (poster != null ? poster.value : this.poster),
        backdrop: (backdrop != null ? backdrop.value : this.backdrop),
        relevancePercentile: (relevancePercentile != null
            ? relevancePercentile.value
            : this.relevancePercentile));
  }
}

@JsonSerializable(explicitToJson: true)
class TitlesResult {
  const TitlesResult({
    this.totalResults,
    required this.page,
    required this.totalPages,
    required this.titles,
  });

  factory TitlesResult.fromJson(Map<String, dynamic> json) =>
      _$TitlesResultFromJson(json);

  static const toJsonFactory = _$TitlesResultToJson;
  Map<String, dynamic> toJson() => _$TitlesResultToJson(this);

  @JsonKey(name: 'total_results')
  final int? totalResults;  // Make nullable
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'titles', defaultValue: <TitleSummary>[])
  final List<TitleSummary> titles;
  static const fromJsonFactory = _$TitlesResultFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TitlesResult &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality()
                    .equals(other.totalResults, totalResults)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality()
                    .equals(other.totalPages, totalPages)) &&
            (identical(other.titles, titles) ||
                const DeepCollectionEquality().equals(other.titles, titles)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(titles) ^
      runtimeType.hashCode;
}

extension $TitlesResultExtension on TitlesResult {
  TitlesResult copyWith(
      {int? totalResults,
      int? page,
      int? totalPages,
      List<TitleSummary>? titles}) {
    return TitlesResult(
        totalResults: totalResults ?? this.totalResults,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        titles: titles ?? this.titles);
  }

  TitlesResult copyWithWrapped(
      {Wrapped<int?>? totalResults,
      Wrapped<int>? page,
      Wrapped<int>? totalPages,
      Wrapped<List<TitleSummary>>? titles}) {
    return TitlesResult(
        totalResults:
            (totalResults != null ? totalResults.value : this.totalResults),
        page: (page != null ? page.value : this.page),
        totalPages: (totalPages != null ? totalPages.value : this.totalPages),
        titles: (titles != null ? titles.value : this.titles));
  }
}

String? sourceTypeNullableToJson(enums.SourceType? sourceType) {
  return sourceType?.value;
}

String? sourceTypeToJson(enums.SourceType sourceType) {
  return sourceType.value;
}

enums.SourceType sourceTypeFromJson(
  Object? sourceType, [
  enums.SourceType? defaultValue,
]) {
  return enums.SourceType.values
          .firstWhereOrNull((e) => e.value == sourceType) ??
      defaultValue ??
      enums.SourceType.swaggerGeneratedUnknown;
}

enums.SourceType? sourceTypeNullableFromJson(
  Object? sourceType, [
  enums.SourceType? defaultValue,
]) {
  if (sourceType == null) {
    return null;
  }
  return enums.SourceType.values
          .firstWhereOrNull((e) => e.value == sourceType) ??
      defaultValue;
}

String sourceTypeExplodedListToJson(List<enums.SourceType>? sourceType) {
  return sourceType?.map((e) => e.value!).join(',') ?? '';
}

List<String> sourceTypeListToJson(List<enums.SourceType>? sourceType) {
  if (sourceType == null) {
    return [];
  }

  return sourceType.map((e) => e.value!).toList();
}

List<enums.SourceType> sourceTypeListFromJson(
  List? sourceType, [
  List<enums.SourceType>? defaultValue,
]) {
  if (sourceType == null) {
    return defaultValue ?? [];
  }

  return sourceType.map((e) => sourceTypeFromJson(e.toString())).toList();
}

List<enums.SourceType>? sourceTypeNullableListFromJson(
  List? sourceType, [
  List<enums.SourceType>? defaultValue,
]) {
  if (sourceType == null) {
    return defaultValue;
  }

  return sourceType.map((e) => sourceTypeFromJson(e.toString())).toList();
}

String? titleTypeNullableToJson(enums.TitleType? titleType) {
  return titleType?.value;
}

String? titleTypeToJson(enums.TitleType titleType) {
  return titleType.value;
}

enums.TitleType titleTypeFromJson(
  Object? titleType, [
  enums.TitleType? defaultValue,
]) {
  return enums.TitleType.values.firstWhereOrNull((e) => e.value == titleType) ??
      defaultValue ??
      enums.TitleType.swaggerGeneratedUnknown;
}

enums.TitleType? titleTypeNullableFromJson(
  Object? titleType, [
  enums.TitleType? defaultValue,
]) {
  if (titleType == null) {
    return null;
  }
  return enums.TitleType.values.firstWhereOrNull((e) => e.value == titleType) ??
      defaultValue;
}

String titleTypeExplodedListToJson(List<enums.TitleType>? titleType) {
  return titleType?.map((e) => e.value!).join(',') ?? '';
}

List<String> titleTypeListToJson(List<enums.TitleType>? titleType) {
  if (titleType == null) {
    return [];
  }

  return titleType.map((e) => e.value!).toList();
}

List<enums.TitleType> titleTypeListFromJson(
  List? titleType, [
  List<enums.TitleType>? defaultValue,
]) {
  if (titleType == null) {
    return defaultValue ?? [];
  }

  return titleType.map((e) => titleTypeFromJson(e.toString())).toList();
}

List<enums.TitleType>? titleTypeNullableListFromJson(
  List? titleType, [
  List<enums.TitleType>? defaultValue,
]) {
  if (titleType == null) {
    return defaultValue;
  }

  return titleType.map((e) => titleTypeFromJson(e.toString())).toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
