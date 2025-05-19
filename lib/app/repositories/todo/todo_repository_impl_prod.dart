import '../../models/model_todo.dart';
import 'todo_repository.dart';

class TodoRepositoryImplProd implements TodoRepository {
  @override
  Future<List<ModelTodo>> getTodo() {
    throw UnimplementedError();
  }

  @override
  Future<void> finish(String answer1, String answer2, ModelTodo todo) {
    throw UnimplementedError();
  }
}
