import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watchflix/api/gen/watchmode_api.enums.swagger.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/utils/result.dart';
import 'package:watchflix/core/widgets/error_view.dart';
import 'package:watchflix/core/widgets/loading_view.dart';
import 'package:watchflix/features/title_details/presentation/cubit/title_details_cubit.dart';

class TitleDetailsScreen extends StatelessWidget {
  const TitleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TitleDetailsCubit, Result<TitleDetails>>(
      builder: (context, state) {
        if (state is Loading) {
          return const Scaffold(
            body: LoadingView(message: 'Loading title details...'),
          );
        }

        if (state is Error) {
          return Scaffold(
            body: ErrorView(
              error: 'error message',
              onRetry: () {
                if (context.read<TitleDetailsCubit>().state
                    is Success<TitleDetails>) {
                  final titleId = (context.read<TitleDetailsCubit>().state
                          as Success<TitleDetails>)
                      .data
                      .id;
                  context.read<TitleDetailsCubit>().loadDetails(titleId);
                }
              },
            ),
          );
        }

        if (state is Success<TitleDetails>) {
          final details = state.data;
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (details.backdrop != null)
                          Image.network(
                            details.backdrop!,
                            fit: BoxFit.cover,
                          )
                        else
                          Image.network(
                            details.poster,
                            fit: BoxFit.cover,
                          ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black87,
                              ],
                            ),
                          ),
                        ),
                        if (details.poster.isNotEmpty)
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Card(
                              elevation: 8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  details.poster,
                                  height: 180,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _getTypeDisplay(details.type),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                details.year.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),

                        // Genres
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: details.genreNames
                                .map(
                                  (genre) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Chip(
                                      label: Text(genre),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),

                        // Plot Overview
                        const SizedBox(height: 24),
                        Text(
                          'Overview',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          details.plotOverview,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),

                        // Ratings
                        const SizedBox(height: 24),
                        Text(
                          'Ratings',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        _buildRatingRow(
                          context,
                          'Critic Score',
                          details.criticScore?.toString() ?? 'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildRatingRow(
                          context,
                          'User Rating',
                          details.userRating?.toStringAsFixed(1) ?? 'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildRatingRow(
                          context,
                          'Relevance',
                          details.relevancePercentile != null
                              ? '${(details.relevancePercentile! >= 99.99 ? 99.99 : details.relevancePercentile!).toStringAsFixed(2)}%'
                              : 'N/A',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRatingRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  String _getTypeDisplay(TitleType type) {
    switch (type) {
      case TitleType.tvSeries:
        return 'TV Series';
      case TitleType.tvMiniseries:
        return 'TV Miniseries';
      case TitleType.tvSpecial:
        return 'TV Special';
      case TitleType.movie:
        return 'Movie';
      case TitleType.swaggerGeneratedUnknown:
        return 'Other';
      default:
        return 'Other';
    }
  }
}
