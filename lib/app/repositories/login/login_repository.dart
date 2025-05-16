import 'package:teste_mundo_wap/app/dto/login_dto.dart';

import '../../models/model_login.dart';

abstract class LoginRepository {
  Future<ModelLogin> login(LoginDto credentials);
}
