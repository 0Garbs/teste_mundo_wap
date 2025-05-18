import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/custom_button.dart';
import '../../models/model_field.dart';
import '../../models/model_todo.dart';
import 'todo_controller.dart';
import 'todo_state.dart';

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
                  ? Icon(Icons.arrow_back, color: Colors.black)
                  : Icon(Icons.chevron_left_sharp, color: Colors.black),
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
                Text(
                  state.selectedTodo?.name ?? '',
                  style: context.textStyles.textBold.copyWith(fontSize: 28),
                ),
                SizedBox(height: 10),
                Text(
                  state.selectedTodo?.description ?? '',
                  style: context.textStyles.textSemiBold.copyWith(fontSize: 20),
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        context.percentHeight(.04),
                        0,
                        0,
                      ),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: fields(state.selectedTodo?.fields ?? []),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  height: 66,
                  width: context.screenWidth,
                  label: 'Finalizar',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await controller.finishTodo(
                        _controller1.text,
                        _controller2.text,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> fields(List<ModelField> questions) {
    return questions.isNotEmpty
        ? [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questions[0].label,
                  style: context.textStyles.textMedium.copyWith(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                textFieldByType(
                  questions[0].type,
                  questions[0].obligatory,
                  _controller1,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questions[1].label,
                  style: context.textStyles.textMedium.copyWith(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                textFieldByType(
                  questions[1].type,
                  questions[1].obligatory,
                  _controller2,
                ),
              ],
            ),
          ),
        ]
        : [];
  }

  Widget textFieldByType(
    String type,
    bool obligatory,
    TextEditingController controller,
  ) {
    switch (type) {
      case 'text':
        return TextFormField(
          controller: controller,
          validator: (value) {
            if ((value == null || value.isEmpty) && obligatory) {
              return 'Campo obrigatorio';
            }
            return null;
          },
        );
      case 'mask_price':
        return TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            CurrencyInputFormatter(
              leadingSymbol: 'R\$',
              thousandSeparator: ThousandSeparator.Period,
              useSymbolPadding: true,
            ),
          ],
          validator: (value) {
            if ((value == null || value.isEmpty) && obligatory) {
              return 'Campo obrigatorio';
            }
            return null;
          },
        );
      case 'mask_date':
        return TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () async {
            DateTime? data = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              locale: const Locale('pt', 'BR'),
            );

            if (data != null) {
              setState(() {
                controller.text = DateFormat('dd/MM/yyyy').format(data);
              });
            }
          },
          validator: (value) {
            if ((value == null || value.isEmpty) && obligatory) {
              return 'Campo obrigatorio';
            }
            return null;
          },
        );
      default:
        return Text('Campo não implementado');
    }
  }
}
