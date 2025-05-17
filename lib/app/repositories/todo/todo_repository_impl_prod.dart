import 'package:teste_mundo_wap/app/models/model_todo_item.dart';

import 'todo_repository.dart';

class TodoRepositoryImplProd implements TodoRepository {
  @override
  Future<List<ModelTodoItem>> getTodo() {
    throw UnimplementedError();
  }
}
