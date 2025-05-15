import 'package:equatable/equatable.dart';
// import 'package:match/match.dart';

// part 'splash_state.g.dart';

// @match
enum SplashStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class SplashState extends Equatable {
  final SplashStateStatus status;
  final String? errorMessage;
  final bool logged;

  const SplashState({
    required this.status,
    this.logged = false,
    this.errorMessage,
  });

  const SplashState.initial()
      : status = SplashStateStatus.initial,
        errorMessage = null,
        logged = false;

  @override
  List<Object?> get props => [status, errorMessage, logged];

  SplashState copyWith({
    SplashStateStatus? status,
    String? errorMessage,
    bool? logged,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      logged: logged ?? false,
    );
  }
}
