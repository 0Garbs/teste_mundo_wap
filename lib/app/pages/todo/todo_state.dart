import 'package:equatable/equatable.dart';

enum TodoStateStatus { initial, loading, loaded, error }

class TodoState extends Equatable {
  final TodoStateStatus status;
  final String? errorMessage;

  const TodoState({required this.status, this.errorMessage});

  const TodoState.initial()
    : status = TodoStateStatus.initial,
      errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  TodoState copyWith({TodoStateStatus? status, String? errorMessage}) {
    return TodoState(status: status ?? this.status, errorMessage: errorMessage);
  }
}
