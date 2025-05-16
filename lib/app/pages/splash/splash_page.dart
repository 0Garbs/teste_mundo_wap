import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/colors_app.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/custom_button.dart';
import 'splash_controller.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashController> {
  @override
  void onReady() {
    controller.initializing();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashController, SplashState>(
        listener: (context, state) async {
          switch (state.status) {
            case SplashStateStatus.initial:
              await controller.checkSession();
              break;
            case SplashStateStatus.loading:
              showLoader();
              break;
            case SplashStateStatus.loaded:
              hideLoader();
              if (state.logged == true) {
                Navigator.of(context).pushReplacementNamed('/page_holder');
              }
              break;
            case SplashStateStatus.error:
              hideLoader();
              showError(state.errorMessage ?? 'Erro não informado');
              break;
          }
        },
        buildWhen: (previous, current) {
          switch (current.status) {
            case SplashStateStatus.initial:
              return true;
            case SplashStateStatus.loading:
              return false;
            case SplashStateStatus.loaded:
              return true;
            case SplashStateStatus.error:
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
                          children: [
                            Text('Logo'),
                          ],
                        )
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
                            // await controller.checkSession();
                            Navigator.of(context).pushNamed('/login');
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
