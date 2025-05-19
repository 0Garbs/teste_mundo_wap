import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_mundo_wap/app/core/ui/base_state/base_state_singleton.dart';
import 'package:teste_mundo_wap/app/pages/home/home_controller.dart';

import '../../repositories/todo/todo_repository.dart';
import '../../repositories/todo/todo_repository_impl_dev.dart';
import '../../repositories/todo/todo_repository_impl_prod.dart';
import 'home_page.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
    providers:
        BaseStateSingleton.i.flavor == Flavors.prod
            ? [
              Provider<TodoRepository>(
                create: (context) => TodoRepositoryImplProd(),
              ),
              Provider(
                create:
                    (context) => HomeController(context.read<TodoRepository>()),
              ),
            ]
            : [
              Provider<TodoRepository>(
                create: (context) => TodoRepositoryImplDev(),
              ),
              Provider(
                create:
                    (context) => HomeController(context.read<TodoRepository>()),
              ),
            ],
    child: HomePage(),
  );
}
