import 'dart:developer';

import 'package:teste_mundo_wap/app/core/exceptions/repository_exception.dart';
import 'package:teste_mundo_wap/app/dto/login_dto.dart';

import 'package:teste_mundo_wap/app/models/model_login.dart';

import '../../core/rest_client/rest_client.dart';
import 'login_repository.dart';

class LoginRepositoryImplProd implements LoginRepository {
  final RestClient _client;

  LoginRepositoryImplProd({required RestClient client}) : _client = client;

  @override
  Future<ModelLogin> login(LoginDto credentials) async {
    try {
      final body = credentials.toJson();
      final result = await _client.postRequest(
        uri: '/TestMobile/auth',
        data: body,
      );

      return ModelLogin.fromMap(result.data);
    } on Exception catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
