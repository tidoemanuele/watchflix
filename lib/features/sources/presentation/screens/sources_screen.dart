import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watchflix/core/router/route_paths.dart';
import 'package:watchflix/core/utils/result.dart';
import 'package:watchflix/features/sources/domain/models/source_category.dart';
import 'package:watchflix/features/sources/presentation/cubit/sources_cubit.dart';
import 'package:watchflix/features/sources/presentation/widgets/source_category_section.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({super.key});

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SourcesCubit>().load();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sources'),
      ),
      body: BlocBuilder<SourcesCubit, Result<CategoryizedSources>>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: message',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.read<SourcesCubit>().load(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is Success<CategoryizedSources>) {
            final sources = state.data;
            return RefreshIndicator.adaptive(
              onRefresh: () => context.read<SourcesCubit>().load(),
              child: ListView.builder(
                itemCount: SourceCategory.values.length,
                itemBuilder: (context, index) {
                  final category = SourceCategory.values[index];
                  final categorySources = switch (category) {
                    SourceCategory.free => sources.freeSources,
                    SourceCategory.purchase => sources.purchaseSources,
                    SourceCategory.tvChannels => sources.tvChannelSources,
                    SourceCategory.subscription => sources.subscriptionSources,
                    SourceCategory.others => sources.otherSources,
                  };

                  return SourceCategorySection(
                    category: category,
                    sources: categorySources,
                    onSourceTap: (source) => context.push(
                      RoutePaths.listTitles,
                      extra: {
                        'sourceIds': source.id.toString(),
                        'source': source,
                      },
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
