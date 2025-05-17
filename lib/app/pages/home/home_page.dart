import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/base_state/base_state_singleton.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'widgets/home_header.dart';
import 'widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.initializing();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) async {
          switch (state.status) {
            case HomeStateSatus.initial:
              await controller.loadTodos();
              break;
            case HomeStateSatus.loading:
              showLoader();
              break;
            case HomeStateSatus.loaded:
              hideLoader();
              break;
            case HomeStateSatus.error:
              hideLoader();
              showError(state.errorMessage ?? 'Erro não informado');
              break;
          }
        },
        buildWhen: (previous, current) {
          switch (current.status) {
            case HomeStateSatus.initial:
              return true;
            case HomeStateSatus.loading:
              return false;
            case HomeStateSatus.loaded:
              return true;
            case HomeStateSatus.error:
              return false;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(
                    name: BaseStateSingleton.i.user?.name,
                    qtyTodo: state.todos.length,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Tarefas',
                    style: context.textStyles.textMedium.copyWith(
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  TodoList(
                    todos: state.todos,
                    onDelete: () {
                      debugPrint('Delete');
                    },
                    onSelect: () {
                      debugPrint('Select');
                    },
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
