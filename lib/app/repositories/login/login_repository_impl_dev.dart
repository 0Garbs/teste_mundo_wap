import 'dart:developer';

import '../../core/database/db_todowap.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../dto/login_dto.dart';
import '../../models/model_login.dart';
import '../../models/model_user.dart';
import 'login_repository.dart';

class LoginRepositoryImplDev implements LoginRepository {
  @override
  Future<ModelLogin> login(LoginDto credentials) async {
    await Future.delayed(Duration(seconds: 2));
    return ModelLogin.fromJson(loginJson);
  }

  @override
  Future<void> saveUser(ModelUser user) async {
    try {
      final dbUser = User(
        user: user.user,
        password: user.password,
        name: user.name,
        profile: user.profile,
      );

      await dbUser.save();
    } on Exception catch (e, s) {
      log('Erro ao gravar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao gravar usuário');
    }
  }

  final loginJson = '''
  {
    "success":true,
    "user":{
        "name":"Nome de teste do usuário",
        "profile":"Promotor",
        "tasks":[
          {
              "id":1,
              "task_name":"Tarefa número 1",
              "description":"Informe o nome e preço do produto",
              "fields":[
                {
                    "id":1,
                    "label":"Nome do produto",
                    "required":true,
                    "field_type":"text"
                },
                {
                    "id":2,
                    "label":"Informe o preço",
                    "required":true,
                    "field_type":"mask_price"
                }
              ]
          },
          {
              "id":2,
              "task_name":"Tarefa número 2",
              "description":"Informe o nome do produto e data de vencimento",
              "fields":[
                {
                    "id":1,
                    "label":"Nome do produto",
                    "required":true,
                    "field_type":"text"
                },
                {
                    "id":2,
                    "label":"Informe o preço",
                    "required":true,
                    "field_type":"mask_date"
                }
              ]
          },
          {
              "id":3,
              "task_name":"Tarefa número 3",
              "description":"Informe o nome do cliente e nome da loja",
              "fields":[
                {
                    "id":1,
                    "label":"Nome do cliente",
                    "required":true,
                    "field_type":"text"
                },
                {
                    "id":2,
                    "label":"nome da loja",
                    "required":true,
                    "field_type":"text"
                }
              ]
          }
        ]
    }
  }
  ''';
}
