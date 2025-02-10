import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/router/route_names.dart';
import 'package:watchflix/core/router/route_paths.dart';
import 'package:watchflix/core/widgets/error_view.dart';
import 'package:watchflix/features/list_titles/data/repositories/titles_repository.dart';
import 'package:watchflix/features/list_titles/domain/usecases/get_titles_usecase.dart';
import 'package:watchflix/features/list_titles/presentation/cubit/titles_cubit.dart';
import 'package:watchflix/features/list_titles/presentation/screens/titles_screen.dart';
import 'package:watchflix/features/sources/data/repositories/sources_repository.dart';
import 'package:watchflix/features/sources/domain/usecases/get_source_by_id_usecase.dart';
import 'package:watchflix/features/sources/domain/usecases/get_sources_usecase.dart';
import 'package:watchflix/features/sources/presentation/cubit/sources_cubit.dart';
import 'package:watchflix/features/sources/presentation/screens/sources_screen.dart';
import 'package:watchflix/features/splash/presentation/screens/splash_screen.dart';
import 'package:watchflix/features/title_details/data/repositories/title_details_repository.dart';
import 'package:watchflix/features/title_details/domain/usecases/get_title_details_usecase.dart';
import 'package:watchflix/features/title_details/presentation/cubit/title_details_cubit.dart';
import 'package:watchflix/features/title_details/presentation/screens/title_details_screen.dart';

abstract class AppRouter {
  static const String initialRoute = RoutePaths.splash;

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    errorBuilder: (context, state) => ErrorView(
      error: state.error.toString(),
      onRetry: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(initialRoute);
        }
      },
    ),
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.sources,
        name: RouteNames.sources,
        builder: (context, state) => BlocProvider.value(
          value: SourcesCubit(
            getSourcesUseCase: GetSourcesUseCase(
              context.read<SourcesRepository>(),
            ),
            getSourceByIdUseCase: GetSourceByIdUseCase(
              context.read<SourcesRepository>(),
            ),
          )..load(),
          child: const SourcesScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.listTitles,
        name: RouteNames.listTitles,
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          final sourceIds = extra['sourceIds'] as String;
          final source = extra['source'] as SourceSummary;

          return BlocProvider.value(
            value: TitlesCubit(
              getTitlesUseCase: GetTitlesUseCase(
                context.read<TitlesRepository>(),
              ),
              sourceIds: sourceIds,
            )..refresh(),
            child: TitlesScreen(
              sourceIds: sourceIds,
              source: source,
            ),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.titleDetails,
        name: RouteNames.titleDetails,
        builder: (context, state) {
          final titleId = state.extra! as int;

          return BlocProvider.value(
            value: TitleDetailsCubit(
              GetTitleDetailsUseCase(
                context.read<TitleDetailsRepository>(),
              ),
            )..loadDetails(titleId),
            child: const TitleDetailsScreen(),
          );
        },
      ),
    ],
  );
}
