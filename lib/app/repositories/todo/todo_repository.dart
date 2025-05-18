import '../../models/model_todo.dart';

abstract class TodoRepository {
  Future<List<ModelTodo>> getTodo();

  Future<void> finish(String answer1, String answer2, ModelTodo todo);
}
