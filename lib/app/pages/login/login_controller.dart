import 'package:bloc/bloc.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../dto/login_dto.dart';
import '../../repositories/login/login_repository.dart';
import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginController(this._loginRepository) : super(const LoginState.initial());

  void initializing() {
    emit(state.copyWith(status: LoginStateStatus.initial));
  }

  Future<void> login({required String user, required String password}) async {
    try {
      emit(state.copyWith(status: LoginStateStatus.loading));

      final result = await _loginRepository.login(
        LoginDto(user: user, password: password),
      );

      // saveUser
      // saveTodos
      // setSingletonInfo

      emit(state.copyWith(status: LoginStateStatus.loaded));
    } catch (error) {
      var msg = 'Ocorreu um error inesperado';
      if (error is RepositoryException) {
        msg = error.message;
      }
      emit(state.copyWith(status: LoginStateStatus.error, errorMessage: msg));
    }
  }
}
