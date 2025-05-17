import '../../models/model_todo_item.dart';

abstract class TodoRepository {
  Future<List<ModelTodoItem>> getTodo();
}
