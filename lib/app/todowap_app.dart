import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/provider/application_binding.dart';
import 'core/ui/theme/theme_config.dart';
import 'pages/login/login_router.dart';
import 'pages/splash/splash_router.dart';

class TodoWapApp extends StatelessWidget {
  const TodoWapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'TodoWap',
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => SplashRouter.page,
          '/login': (context) => LoginRouter.page,
        },
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          // Locale('en', 'US'),
        ],
      ),
    );
  }
}
