import 'package:equatable/equatable.dart';

enum LoginStateStatus { initial, loading, loaded, error }

class LoginState extends Equatable {
  final LoginStateStatus status;
  final String? errorMessage;

  const LoginState({required this.status, this.errorMessage});

  const LoginState.initial()
    : status = LoginStateStatus.initial,
      errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  

  LoginState copyWith({
    LoginStateStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
