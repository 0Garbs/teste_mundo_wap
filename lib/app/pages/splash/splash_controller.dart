import 'package:bloc/bloc.dart';

import '../../core/database/db_todowap.dart';
import '../../core/ui/base_state/base_state_singleton.dart';
import '../../models/model_user.dart';
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

      if (perfil != null) {
        logged = true;
        BaseStateSingleton.i.setUser(
          ModelUser(
            user: perfil.user!,
            password: perfil.password!,
            name: perfil.name!,
            profile: perfil.profile!,
          ),
        );
      }

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
