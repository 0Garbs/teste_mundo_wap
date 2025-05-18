import 'dart:developer';

import 'package:teste_mundo_wap/app/models/model_field.dart';
import 'package:teste_mundo_wap/app/models/model_todo.dart';

import '../../core/database/db_todowap.dart';
import '../../core/exceptions/repository_exception.dart';
import 'todo_repository.dart';

class TodoRepositoryImplDev implements TodoRepository {
  @override
  Future<List<ModelTodo>> getTodo() async {
    try {
      var items = <ModelTodo>[];

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
          done: dbTodo.done ?? false,
        );

        items.add(todo);
      }

      return items;
    } on Exception catch (e, s) {
      log('Erro ao buscar tarefas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar tarefas');
    }
  }

  @override
  Future<void> finish(String answer1, String answer2, ModelTodo todo) async {
    try {
      // save Todo answer
      final dbAnswer1 = TodoAnswer(
        idTodoField: todo.fields[0].id,
        answer: answer1,
      );
      final dbAnswer2 = TodoAnswer(
        idTodoField: todo.fields[1].id,
        answer: answer2,
      );

      await dbAnswer1.save();
      await dbAnswer2.save();

      var selectedTodo =
          await TodoHeader().select().id.equals(todo.id).toSingle();

      selectedTodo!.done = true;
      await selectedTodo.save();
    } on Exception catch (e, s) {
      log('Erro ao gravar as respostas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao gravar as respostas');
    }
  }
}
