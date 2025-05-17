import 'package:bloc/bloc.dart';

import 'todo_state.dart';

class TodoController extends Cubit<TodoState> {
  TodoController() : super(TodoState.initial());

  void initializing() {
    emit(state.copyWith(status: TodoStateStatus.initial));
  }
}
