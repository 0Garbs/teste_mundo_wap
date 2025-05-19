import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest_client/rest_client.dart';
import '../../core/ui/base_state/base_state_singleton.dart';
import '../../repositories/login/login_repository.dart';
import '../../repositories/login/login_repository_impl_prod.dart';
import '../../repositories/login/login_repository_impl_dev.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
    providers:
        BaseStateSingleton.i.flavor == Flavors.prod
            ? [
              Provider<LoginRepository>(
                create:
                    (context) =>
                        LoginRepositoryImplProd(client: context.read<RestClient>()),
              ),
              Provider(
                create:
                    (context) =>
                        LoginController(context.read<LoginRepository>()),
              ),
            ]
            : [
              Provider<LoginRepository>(
                create:
                    (context) =>
                        LoginRepositoryImplDev(),
              ),
              Provider(
                create:
                    (context) =>
                        LoginController(context.read<LoginRepository>()),
              ),
            ],
    child: LoginPage(),
  );
}
