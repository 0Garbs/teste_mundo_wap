import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/env/env.dart';
import '../rest_client/rest_client.dart';
import '../rest_client/rest_client_impl.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RestClient>(create: (context) => RestClientImpl(baseUrl: Env.i['base'] ?? 'localhost:8080')),
      ],
      child: child,
    );
  }
}
