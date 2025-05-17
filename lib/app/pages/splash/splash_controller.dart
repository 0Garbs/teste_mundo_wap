import 'package:bloc/bloc.dart';

import '../../core/database/db_todowap.dart';
import 'splash_state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(const SplashState.initial());

  void initializing() {
    emit(state.copyWith(status: SplashStateStatus.initial));
  }

  Future<void> checkSession() async {
    try {
      bool logged = false;

      emit(state.copyWith(status: SplashStateStatus.loading));

      final perfil = await User().select().toSingle();

      logged = perfil != null;

      emit(state.copyWith(status: SplashStateStatus.loaded, logged: logged));
    } catch (e) {
      emit(
        state.copyWith(
          status: SplashStateStatus.error,
          logged: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
