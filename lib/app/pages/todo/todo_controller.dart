import 'package:bloc/bloc.dart';

import '../../models/model_todo.dart';
import '../../repositories/todo/todo_repository.dart';
import 'todo_state.dart';

class TodoController extends Cubit<TodoState> {
  final TodoRepository _todoRepository;

  TodoController(this._todoRepository) : super(TodoState.initial());

  void initializing() {
    emit(state.copyWith(status: TodoStateStatus.initial));
  }

  void setSelectedTodo(ModelTodo todo) {
    emit(state.copyWith(status: TodoStateStatus.loaded, selectedTodo: todo));
  }

  Future<void> finishTodo(String answer1, String answer2) async {
    try {
      emit(state.copyWith(status: TodoStateStatus.loading));

      await _todoRepository.finish(answer1, answer2, state.selectedTodo!);

      emit(state.copyWith(status: TodoStateStatus.loaded, finished: true));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: TodoStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
