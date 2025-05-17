import 'package:teste_mundo_wap/app/dto/login_dto.dart';

import '../../models/model_login.dart';
import '../../models/model_todo.dart';
import '../../models/model_user.dart';

abstract class LoginRepository {
  Future<ModelLogin> login(LoginDto credentials);

  Future<void> saveUser(ModelUser user);

  Future<void> saveTodos(List<ModelTodo> todos);
}
