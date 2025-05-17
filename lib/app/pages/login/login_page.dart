import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/colors_app.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/custom_button.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  @override
  void onReady() {
    controller.initializing();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginController, LoginState>(
        listener: (context, state) async {
          switch (state.status) {
            case LoginStateStatus.initial:
              // await controller.checkSession();
              break;
            case LoginStateStatus.loading:
              showLoader();
              break;
            case LoginStateStatus.loaded:
              hideLoader();
              Navigator.of(context).pushReplacementNamed('/home');
              break;
            case LoginStateStatus.error:
              hideLoader();
              showError(state.errorMessage ?? 'Erro não informado');
              break;
          }
        },
        buildWhen: (previous, current) {
          switch (current.status) {
            case LoginStateStatus.initial:
              return true;
            case LoginStateStatus.loading:
              return false;
            case LoginStateStatus.loaded:
              return true;
            case LoginStateStatus.error:
              return false;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: ColoredBox(
              color: context.colors.background,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 50,
                      right: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: context.screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Login')],
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 25),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: context.percentHeight(.57)),
                        SizedBox(height: context.percentHeight(.08)),
                        CustomButton(
                          label: 'Criar',
                          width: context.percentWidth(.9),
                          height: 76,
                          onPressed: () async {},
                        ),
                        SizedBox(height: context.percentHeight(.02)),
                        CustomButton(
                          label: 'Entrar',
                          width: context.percentWidth(.9),
                          height: 76,
                          onPressed: () async {
                            await controller.login(
                              user: 'teste.mobile',
                              password: '1234',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
