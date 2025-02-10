import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:watchflix/app_config.dart';
import 'package:watchflix/core/router/app_router.dart';
import 'package:watchflix/core/services/watchmode_service.dart';
import 'package:watchflix/features/list_titles/data/repositories/titles_repository.dart';
import 'package:watchflix/features/sources/data/repositories/sources_repository.dart';
import 'package:watchflix/features/title_details/data/repositories/title_details_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove '#' from web URLs
  setPathUrlStrategy();

  if (kReleaseMode) {
    ErrorWidget.builder = (_) => const SizedBox.shrink();
  }

  runApp(
    Provider.value(
      value: AppConfig(
        watchmodeBaseUrl: Uri.parse('https://api.watchmode.com/v1'),
        watchmodeApiKey: 'YOUR_API_KEY_HERE',
      ),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _buildProviders(context),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  List<SingleChildWidget> _buildProviders(BuildContext context) {
    final config = context.read<AppConfig>();

    return [
      // Core Services
      Provider(
        create: (context) => WatchmodeService(config),
      ),

      // Feature: Sources
      Provider(
        create: (context) => SourcesRepository(
          context.read<WatchmodeService>(),
        ),
      ),

      // Feature: Titles
      Provider(
        create: (context) => TitlesRepository(
          context.read<WatchmodeService>(),
        ),
      ),

      // Feature: Title Details
      Provider(
        create: (context) => TitleDetailsRepository(
          context.read<WatchmodeService>(),
        ),
      ),
    ];
  }
}
