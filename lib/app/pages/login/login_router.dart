import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest_client/rest_client.dart';
import '../../repositories/login/login_repository.dart';
import '../../repositories/login/login_repository_impl.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
    providers: [
      Provider<LoginRepository>(
        create:
            (context) =>
                LoginRepositoryImpl(client: context.read<RestClient>()),
      ),
      Provider(
        create: (context) => LoginController(context.read<LoginRepository>()),
      ),
    ],
    child: LoginPage(),
  );
}
