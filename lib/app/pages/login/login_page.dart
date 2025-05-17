import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';

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
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

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
              break;
            case LoginStateStatus.loading:
              showLoader();
              break;
            case LoginStateStatus.loaded:
              hideLoader();
              Navigator.of(context).pop();
              Navigator.of(context).popAndPushNamed('/home');
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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: context.percentHeight(.08)),
                    Text('User:'),
                    SizedBox(height: 8.0),
                    TextField(controller: _userController),
                    SizedBox(height: context.percentHeight(.04)),
                    Text('Password:'),
                    SizedBox(height: 8.0),
                    TextField(controller: _passwordController),
                    SizedBox(height: context.percentHeight(.1)),
                    CustomButton(
                      label: 'Entrar',
                      width: context.screenWidth,
                      height: 76,
                      onPressed: () async {
                        await controller.login(
                          user: _userController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
