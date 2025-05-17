import 'dart:convert';

import 'model_todo.dart';
import 'model_user.dart';

class ModelLogin {
  final ModelUser user;
  final List<ModelTodo> todos;
  ModelLogin({required this.user, required this.todos});

  ModelLogin copyWith({ModelUser? user, List<ModelTodo>? todos}) {
    return ModelLogin(user: user ?? this.user, todos: todos ?? this.todos);
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelLogin.fromMap(Map<String, dynamic> map) {
    return ModelLogin(
      user: ModelUser.fromMap(map['user']),
      todos: List<ModelTodo>.from(
        map['user']['tasks']?.map((x) => ModelTodo.fromMap(x)) ?? const [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelLogin.fromJson(String source) =>
      ModelLogin.fromMap(json.decode(source));
}
