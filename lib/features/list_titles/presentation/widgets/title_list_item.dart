import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watchflix/features/list_titles/domain/models/title_item.dart';

/// A widget that displays a single title item in a list.
///
/// This widget is responsible for rendering a movie or TV show title with its
/// metadata (type, year) in a consistent layout. It uses a [ListTile] wrapped
/// in a styled container for visual appeal and includes:
/// - Title of the movie/show
/// - Type indicator (Movie, TV Series, etc.)
/// - Year of release (if available)
///
/// The widget is also interactive, handling navigation to detail view when tapped.
class TitleListItem extends StatelessWidget {
  const TitleListItem({
    super.key,
    required this.item,
  });

  final TitleItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withAlpha(26),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(204),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.typeDisplay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (item.year != null)
                Text(
                  item.year.toString(),
                  style: TextStyle(
                    color: Colors.red.withAlpha(179),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          onTap: () => context.push(
            '/title_details',
            extra: item.id,
          ),
        ),
      ),
    );
  }
}
