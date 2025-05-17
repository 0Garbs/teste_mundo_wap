import 'dart:developer';

import '../../core/database/db_todowap.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/rest_client.dart';
import '../../dto/login_dto.dart';
import '../../models/model_login.dart';
import '../../models/model_todo.dart';
import '../../models/model_user.dart';
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

  @override
  Future<void> saveTodos(List<ModelTodo> todos) async {
    try {
      for (var todo in todos) {
        final dbTodo = TodoHeader(
          id: todo.id,
          name: todo.name,
          description: todo.description,
        );

        await dbTodo.save();

        for (var field in todo.fields) {
          final dbField = TodoField(
            id: field.id,
            idTodo: todo.id,
            label: field.label,
            obligatory: field.obligatory,
            type: field.type,
          );

          await dbField.save();
        }
      }
    } on Exception catch (e, s) {
      log('Erro ao gravar Tarefas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao gravar tarefas');
    }
  }
}
