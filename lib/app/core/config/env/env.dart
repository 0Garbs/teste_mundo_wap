import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Env? _instance;
  // Avoid self
  Env._();
  static Env get i => _instance ??= Env._();

  Future<void> load() => dotenv.load();

  String? operator [](String key) => dotenv.env[key];
}
