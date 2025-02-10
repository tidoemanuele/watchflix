// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchmode_api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceSummary _$SourceSummaryFromJson(Map<String, dynamic> json) =>
    SourceSummary(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: sourceTypeFromJson(json['type']),
      logo100px: json['logo_100px'] as String,
      regions: (json['regions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$SourceSummaryToJson(SourceSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': sourceTypeToJson(instance.type),
      'logo_100px': instance.logo100px,
      'regions': instance.regions,
    };

TitleSummary _$TitleSummaryFromJson(Map<String, dynamic> json) => TitleSummary(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      year: (json['year'] as num).toInt(),
      type: titleTypeFromJson(json['type']),
    );

Map<String, dynamic> _$TitleSummaryToJson(TitleSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'type': titleTypeToJson(instance.type),
    };

TitleDetails _$TitleDetailsFromJson(Map<String, dynamic> json) => TitleDetails(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      plotOverview: json['plot_overview'] as String,
      type: titleTypeFromJson(json['type']),
      year: (json['year'] as num).toInt(),
      genreNames: (json['genre_names'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      userRating: (json['user_rating'] as num?)?.toDouble(),
      criticScore: (json['critic_score'] as num?)?.toInt(),
      poster: json['poster'] as String,
      backdrop: json['backdrop'] as String?,
      relevancePercentile: (json['relevance_percentile'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TitleDetailsToJson(TitleDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'plot_overview': instance.plotOverview,
      'type': titleTypeToJson(instance.type),
      'year': instance.year,
      'genre_names': instance.genreNames,
      'user_rating': instance.userRating,
      'critic_score': instance.criticScore,
      'poster': instance.poster,
      'backdrop': instance.backdrop,
      'relevance_percentile': instance.relevancePercentile,
    };

TitlesResult _$TitlesResultFromJson(Map<String, dynamic> json) => TitlesResult(
      totalResults: json['total_results'] == null
          ? null
          : (json['total_results'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      titles: (json['titles'] as List<dynamic>?)
              ?.map((e) => TitleSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TitlesResultToJson(TitlesResult instance) =>
    <String, dynamic>{
      'total_results': instance.totalResults,
      'page': instance.page,
      'total_pages': instance.totalPages,
      'titles': instance.titles.map((e) => e.toJson()).toList(),
    };
