import 'package:flutter/material.dart';
import 'package:watchflix/api/gen/watchmode_api.swagger.dart';
import 'package:watchflix/features/sources/domain/models/source_category.dart';

import 'source_item.dart';

class SourceCategorySection extends StatelessWidget {
  const SourceCategorySection({
    super.key,
    required this.category,
    required this.sources,
    required this.onSourceTap,
  });

  final SourceCategory category;
  final List<SourceSummary> sources;
  final void Function(SourceSummary source) onSourceTap;

  @override
  Widget build(BuildContext context) {
    if (sources.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            children: [
              Text(
                category.displayName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${sources.length})',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return SourceItem(
                source: sources[index],
                onTap: () => onSourceTap(sources[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
