import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_mundo_wap/app/pages/todo/todo_page.dart';

import '../../core/ui/base_state/base_state_singleton.dart';
import '../../repositories/todo/todo_repository.dart';
import '../../repositories/todo/todo_repository_impl_dev.dart';
import '../../repositories/todo/todo_repository_impl_prod.dart';
import 'todo_controller.dart';

class TodoRouter {
  TodoRouter._();

  static Widget get page => MultiProvider(
    providers:
        BaseStateSingleton.i.flavor == Flavors.prod
            ? [
              Provider<TodoRepository>(
                create: (context) => TodoRepositoryImplProd(),
              ),
              Provider(
                create:
                    (context) => TodoController(context.read<TodoRepository>()),
              ),
            ]
            : [
              Provider<TodoRepository>(
                create: (context) => TodoRepositoryImplDev(),
              ),
              Provider(
                create:
                    (context) => TodoController(context.read<TodoRepository>()),
              ),
            ],
    child: TodoPage(),
  );
}
