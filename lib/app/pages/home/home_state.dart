import 'package:equatable/equatable.dart';

enum HomeStateSatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStateSatus status;
  final String? errorMessage;

  const HomeState({required this.status, this.errorMessage});

  const HomeState.initial()
    : status = HomeStateSatus.initial,
      errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  HomeState copyWith({HomeStateSatus? status, String? errorMessage}) {
    return HomeState(status: status ?? this.status, errorMessage: errorMessage);
  }
}
