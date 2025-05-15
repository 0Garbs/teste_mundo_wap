import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_controller.dart';
import 'splash_page.dart';

class SplashRouter {
  SplashRouter._();

  static Widget get page => MultiProvider(
    providers: [Provider(create: (context) => SplashController())],
    child: const SplashPage(),
  );
}
