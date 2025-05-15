import 'package:flutter/foundation.dart';

class BaseStateSingleton extends ChangeNotifier {
  static BaseStateSingleton? _instance;
  // Avoid self instance
  BaseStateSingleton._();
  static BaseStateSingleton get i => _instance ??= BaseStateSingleton._();

  // ModelPerfil? user;

  // void setUser(ModelPerfil pUser) {
  //   user = pUser;
  //   notifyListeners();
  // }

  // void clean() {
  //   user = null;
  //   notifyListeners();
  // }
}
