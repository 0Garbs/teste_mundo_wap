import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_mundo_wap/app/pages/todo/todo_page.dart';

import '../../core/ui/base_state/base_state_singleton.dart';
import 'todo_controller.dart';

class TodoRouter {
  TodoRouter._();

  static Widget get page => MultiProvider(
    providers:
        BaseStateSingleton.i.flavor == Flavors.prod
            ? [Provider(create: (context) => TodoController())]
            : [Provider(create: (context) => TodoController())],
    child: TodoPage(),
  );
}
