import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

import '../../../models/model_todo.dart';
import 'todo_card.dart';

class TodoList extends StatelessWidget {
  final List<ModelTodo> todos;
  final Function() onDelete;
  final Function(ModelTodo) onSelect;

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

  List<Widget> todosList(List<ModelTodo> pTodos, BuildContext context) {
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
      ...undoneTodos.map(
        (todo) => TodoCard(
          item: todo,
          onDelete: onDelete,
          onSelect: (item) => onSelect(todo),
        ),
      ),

      if (doneTodos.isNotEmpty && undoneTodos.isNotEmpty) Divider(),

      ...doneTodos.map(
        (todo) => TodoCard(item: todo, onDelete: () {}, onSelect: (item) {}),
      ),
    ];
  }
}
