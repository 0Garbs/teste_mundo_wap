import 'package:flutter/foundation.dart';
import 'package:teste_mundo_wap/app/models/model_todo.dart';

import '../../../models/model_user.dart';

enum Flavors { dev, prod }

class BaseStateSingleton extends ChangeNotifier {
  final String baseUrl;
  final Flavors flavor;

  static BaseStateSingleton? _instance;
  // Avoid self instance
  BaseStateSingleton._({required this.flavor, required this.baseUrl});

  factory BaseStateSingleton({
    required String baseUrl,
    required Flavors flavor,
  }) {
    _instance ??= BaseStateSingleton._(flavor: flavor, baseUrl: baseUrl);
    return _instance!;
  }

  static BaseStateSingleton get i => _instance!;

  ModelUser? user;
  List<ModelTodo> todos = [];

  void setUser(ModelUser pUser) {
    user = pUser;
    notifyListeners();
  }

  void setTodos(List<ModelTodo> pTodos) {
    todos = [...pTodos];
    notifyListeners();
  }

  void clean() {
    user = null;
    notifyListeners();
  }
}
