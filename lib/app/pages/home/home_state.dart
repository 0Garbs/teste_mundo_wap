import 'package:equatable/equatable.dart';

import '../../models/model_todo.dart';

enum HomeStateSatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStateSatus status;
  final List<ModelTodo> todos;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.todos = const [],
    this.errorMessage,
  });

  const HomeState.initial()
    : status = HomeStateSatus.initial,
      todos = const [],
      errorMessage = null;

  @override
  List<Object?> get props => [status, todos, errorMessage];

  HomeState copyWith({
    HomeStateSatus? status,
    List<ModelTodo>? todos,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorMessage: errorMessage,
    );
  }
}
