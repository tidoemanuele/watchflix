import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum SourceType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('sub')
  sub('sub'),
  @JsonValue('free')
  free('free'),
  @JsonValue('purchase')
  purchase('purchase'),
  @JsonValue('tve')
  tve('tve');

  final String? value;

  const SourceType(this.value);
}

enum TitleType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('movie')
  movie('movie'),
  @JsonValue('tv_series')
  tvSeries('tv_series'),
  @JsonValue('tv_special')
  tvSpecial('tv_special'),
  @JsonValue('tv_miniseries')
  tvMiniseries('tv_miniseries'),
  @JsonValue('short_film')
  shortFilm('short_film');

  final String? value;

  const TitleType(this.value);
}
