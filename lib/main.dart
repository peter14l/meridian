import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app/router.dart';
import 'app/theme.dart';
import 'data/services/supabase_service.dart';
import 'providers/theme_provider.dart';
import 'features/widgets/widget_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();

  await GoogleSignIn.instance.initialize();

  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: MeridianApp(),
      ),
    ),
  );
}

class MeridianApp extends ConsumerWidget {
  const MeridianApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    
    // Initialize widget controller to keep home screen widgets in sync
    ref.listen(widgetControllerProvider, (previous, next) {});

    return MaterialApp.router(
      title: 'Meridian',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return SentryScreenshotWidget(
          child: SentryUserInteractionWidget(
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
