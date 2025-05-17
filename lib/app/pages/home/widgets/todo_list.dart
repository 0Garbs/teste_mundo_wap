import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';

import '../../../models/model_todo_item.dart';
import 'todo_card.dart';

class TodoList extends StatelessWidget {
  final List<ModelTodoItem> todos;
  final Function() onDelete;
  final Function() onSelect;

  const TodoList({
    super.key,
    required this.todos,
    required this.onDelete,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(child: ListView(children: todosList(todos, context))),
    );
  }

  List<Widget> todosList(List<ModelTodoItem> pTodos, BuildContext context) {
    if (pTodos.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.fromLTRB(
            10.0,
            context.percentHeight(.08),
            10.0,
            0.0,
          ),
          child: Placeholder(),
        ),
      ];
    }

    var doneTodos = todos.where((todo) => todo.done).toList();
    var undoneTodos = todos.where((todo) => !todo.done).toList();

    return [
      ...doneTodos.map(
        (todo) => TodoCard(
          title: todo.todo.name,
          description: todo.todo.description,
          done: todo.done,
          onDelete: onDelete,
          onSelect: onSelect,
        ),
      ),

      if (doneTodos.isNotEmpty && undoneTodos.isNotEmpty) Divider(),

      ...undoneTodos.map(
        (todo) => TodoCard(
          title: todo.todo.name,
          description: todo.todo.description,
          done: todo.done,
          onDelete: onDelete,
          onSelect: onSelect,
        ),
      ),
    ];
  }
}
