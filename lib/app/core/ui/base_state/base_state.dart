import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:provider/provider.dart';

import '../helpers/loader.dart';
import '../helpers/messages.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, Messages {
  late final C controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  void onReady() {}

  void leftSession() {
    Navigator.of(context).popAndPushNamed('/');
  }
}
