import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_mundo_wap/app/core/ui/base_state/base_state_singleton.dart';
import 'package:teste_mundo_wap/app/pages/home/home_controller.dart';

import 'home_page.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
    providers:
        BaseStateSingleton.i.flavor == Flavors.prod
            ? [Provider(create: (context) => HomeController())]
            : [Provider(create: (context) => HomeController())],
    child: HomePage(),
  );
}
