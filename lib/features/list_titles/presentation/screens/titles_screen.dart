import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_cubit_utils/leancode_cubit_utils.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/widgets/loading_view.dart';
import 'package:watchflix/features/list_titles/domain/models/title_item.dart';
import 'package:watchflix/features/list_titles/presentation/cubit/titles_cubit.dart';

class TitlesScreen extends StatelessWidget {
  const TitlesScreen({
    super.key,
    required this.sourceIds,
    required this.source,
  });

  final String sourceIds;
  final SourceSummary source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              collapsedHeight: 80,
              pinned: true,
              backgroundColor: Colors.black,
              stretch: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  children: [
                    Hero(
                      tag: 'source-logo-${source.id}',
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(source.logo100px),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        source.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                background: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color(0x80000000),
                    BlendMode.srcOver,
                  ),
                  child: Image.network(
                    source.logo100px,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<TitlesCubit, PaginatedState<void, TitleItem>>(
          builder: (context, state) {
            if (state.type == PaginatedStateType.firstPageLoading) {
              return LoadingView(
                message: 'Loading titles from ${source.name}...',
              );
            }

            if (state.type == PaginatedStateType.firstPageError) {
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
                      'Error: ${state.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                    FilledButton.icon(
                      onPressed: () => context.read<TitlesCubit>().refresh(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state.items.isEmpty && !state.hasNextPage) {
              return LoadingView(
                message: 'Loading titles from ${source.name}...',
              );
            }

            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.items.length + (state.hasNextPage ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.items.length) {
                    if (state.type != PaginatedStateType.nextPageLoading) {
                      // context.read<TitlesCubit>().refresh(); // todo improve this
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  final item = state.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0x0DFFFFFF), // 5% opacity white
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xCC880000,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item.typeDisplay,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              if (item.year != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  item.year.toString(),
                                  style: const TextStyle(
                                    color:
                                        Color(0xB3FFFFFF), // 70% opacity white
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Color(0x8AFFFFFF), // 54% opacity white
                        ),
                        onTap: () =>
                            context.push('/title_details', extra: item.id),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
