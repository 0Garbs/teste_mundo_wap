import 'package:bloc/bloc.dart';

import '../../repositories/todo/todo_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final TodoRepository _todoRepository;

  HomeController(this._todoRepository) : super(HomeState.initial());

  void initializing() {
    emit(state.copyWith(status: HomeStateSatus.initial));
  }

  Future<void> loadTodos() async {
    try {
      emit(state.copyWith(status: HomeStateSatus.loading));

      // get Todos
      final todos = await _todoRepository.getTodo();

      emit(state.copyWith(status: HomeStateSatus.loaded, todos: todos));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: HomeStateSatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
