import 'dart:developer';

import 'package:teste_mundo_wap/app/models/model_field.dart';
import 'package:teste_mundo_wap/app/models/model_todo.dart';

import '../../core/database/db_todowap.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../models/model_todo_item.dart';
import 'todo_repository.dart';

class TodoRepositoryImplDev implements TodoRepository {
  @override
  Future<List<ModelTodoItem>> getTodo() async {
    try {
      var items = <ModelTodoItem>[];

      final dbTodos = await TodoHeader().select().toList();

      for (var dbTodo in dbTodos) {
        final dbFields =
            await TodoField().select().idTodo.equals(dbTodo.id).toList();

        final todo = ModelTodo(
          id: dbTodo.id!,
          name: dbTodo.name!,
          description: dbTodo.description!,
          fields:
              dbFields
                  .map(
                    (e) => ModelField(
                      id: e.id!,
                      label: e.label!,
                      obligatory: e.obligatory!,
                      type: e.type!,
                    ),
                  )
                  .toList(),
        );

        items.add(ModelTodoItem(done: false, todo: todo));
      }

      return items;
    } on Exception catch (e, s) {
      log('Erro ao buscar tarefas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tarefas');
    }
  }
}
