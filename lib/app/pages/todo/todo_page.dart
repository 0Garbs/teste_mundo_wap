import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import 'todo_controller.dart';
import 'todo_state.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends BaseState<TodoPage, TodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon:
              Platform.isAndroid
                  ? Icon(Icons.arrow_back, color: Colors.black)
                  : Icon(Icons.chevron_left_sharp, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<TodoController, TodoState>(
        listener: (context, state) async {
          switch (state.status) {
            case TodoStateStatus.initial:
              // loadTodoPageInfo
              break;
            case TodoStateStatus.loading:
              showLoader();
              break;
            case TodoStateStatus.loaded:
              hideLoader();
              break;
            case TodoStateStatus.error:
              hideLoader();
              showError(state.errorMessage ?? 'Erro nao informado');
              break;
          }
        },
        buildWhen: (previous, current) {
          switch (current.status) {
            case TodoStateStatus.initial:
              return true;
            case TodoStateStatus.loading:
              return false;
            case TodoStateStatus.loaded:
              return true;
            case TodoStateStatus.error:
              return false;
          }
        },
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
