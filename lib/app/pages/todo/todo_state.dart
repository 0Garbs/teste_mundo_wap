import 'package:equatable/equatable.dart';

import '../../models/model_todo.dart';

enum TodoStateStatus { initial, loading, loaded, error }

class TodoState extends Equatable {
  final TodoStateStatus status;
  final ModelTodo? selectedTodo;
  final bool finished;
  final String? errorMessage;

  const TodoState({
    required this.status,
    required this.selectedTodo,
    required this.finished,
    this.errorMessage,
  });

  const TodoState.initial()
    : status = TodoStateStatus.initial,
      selectedTodo = null,
      finished = false,
      errorMessage = null;

  @override
  List<Object?> get props => [status, selectedTodo, finished, errorMessage];

  TodoState copyWith({
    TodoStateStatus? status,
    ModelTodo? selectedTodo,
    bool? finished,
    String? errorMessage,
  }) {
    return TodoState(
      status: status ?? this.status,
      selectedTodo: selectedTodo ?? this.selectedTodo,
      finished: finished ?? this.finished,
      errorMessage: errorMessage,
    );
  }
}
