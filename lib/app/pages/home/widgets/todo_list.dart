import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

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
            0.0,
            context.percentHeight(.05),
            0.0,
            0.0,
          ),
          child: Column(
            children: [
              Image.asset('assets/images/empty_box.png', fit: BoxFit.cover),
              Text(
                'Nenhuma tarefa encontrada,\nvolte mais tarde',
                style: context.textStyles.textMedium.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
