import 'package:bloc/bloc.dart';

import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController() : super(HomeState.initial());

  void initializing() {
    emit(state.copyWith(status: HomeStateSatus.initial));
  }
}
