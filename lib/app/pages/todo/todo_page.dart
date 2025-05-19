import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';
import 'package:teste_mundo_wap/app/pages/todo/widgets/todo_fields.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/custom_button.dart';
import '../../models/model_todo.dart';
import 'todo_controller.dart';
import 'todo_state.dart';
import 'widgets/todo_header.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends BaseState<TodoPage, TodoController> {
  final _formKey = GlobalKey<FormState>();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  void onReady() {
    controller.initializing();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon:
              Platform.isAndroid
                  ? Icon(Icons.arrow_back, color: Colors.black, size: 40)
                  : Icon(
                    Icons.chevron_left_sharp,
                    color: Colors.black,
                    size: 40,
                  ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<TodoController, TodoState>(
        listener: (context, state) async {
          switch (state.status) {
            case TodoStateStatus.initial:
              controller.setSelectedTodo(
                ModalRoute.of(context)?.settings.arguments as ModelTodo,
              );
              // loadTodoPageInfo
              break;
            case TodoStateStatus.loading:
              showLoader();
              break;
            case TodoStateStatus.loaded:
              hideLoader();
              if (state.finished) {
                Navigator.of(context).pop(true);
              }
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
          return Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodoHeader(
                  title: state.selectedTodo?.name ?? '',
                  description: state.selectedTodo?.description ?? '',
                ),

                TodoFields(
                  formKey: _formKey,
                  controller1: _controller1,
                  controller2: _controller2,
                  fields: state.selectedTodo?.fields ?? [],
                ),

                CustomButton(
                  height: 66,
                  width: context.screenWidth,
                  label: 'Finalizar',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await controller.finishTodo(
                        convertToSpecificType(
                          _controller1.text,
                          state.selectedTodo!.fields[0].type,
                        ),
                        convertToSpecificType(
                          _controller2.text,
                          state.selectedTodo!.fields[1].type,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  String convertToSpecificType(String text, String type) {
    switch (type) {
      case 'text':
        return text;
      case 'mask_price':
        final value =
            text
                .replaceAll("R\$", "")
                .replaceAll(".", "")
                .replaceAll(",", ".")
                .trim();

        return value;
      case 'mask_date':
        DateTime dataConvertida = DateFormat('dd/MM/yyyy').parse(text);
        String value = dataConvertida.toIso8601String();

        return value;
      default:
        return '';
    }
  }
}
