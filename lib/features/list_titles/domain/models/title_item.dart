import 'package:flutter/material.dart';
import 'package:watchflix/api/gen/watchmode_api.swagger.dart';

class TitleItem {
  const TitleItem({
    required this.title,
    this.year,
    required this.id,
    required this.type,
  });

  factory TitleItem.fromTitleSummary(TitleSummary summary) {
    return TitleItem(
      title: summary.title,
      year: summary.year,
      id: summary.id,
      type: summary.type,
    );
  }

  final String title;
  final int? year;
  final int id;
  final TitleType type;

  String get typeDisplay {
    switch (type) {
      case TitleType.tvSeries:
        return 'TV series';
      case TitleType.tvMiniseries:
        return 'TV miniseries';
      case TitleType.tvSpecial:
        return 'TV special';
      case TitleType.movie:
        return 'Movie';
      case TitleType.swaggerGeneratedUnknown:
        return 'Other';
      default:
        return 'Other';
    }
  }

  IconData get typeIcon {
    switch (type) {
      case TitleType.tvSeries:
      case TitleType.tvMiniseries:
      case TitleType.tvSpecial:
        return Icons.tv;
      case TitleType.movie:
        return Icons.movie;
      case TitleType.swaggerGeneratedUnknown:
      default:
        return Icons.play_circle_outline;
    }
  }
}
