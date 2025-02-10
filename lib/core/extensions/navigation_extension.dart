import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/router/route_paths.dart';

extension NavigationExtension on BuildContext {
  void navigateToTitles(SourceSummary source) {
    push(
      '${RoutePaths.listTitles}/${source.id}',
      extra: {
        'sourceIds': source.id.toString(),
        'source': source,
      },
    );
  }
}
