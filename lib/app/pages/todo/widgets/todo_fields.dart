import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:teste_mundo_wap/app/core/ui/helpers/size_extensions.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

import '../../../models/model_field.dart';

class TodoFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final List<ModelField> fields;

  const TodoFields({
    super.key,
    required this.formKey,
    required this.controller1,
    required this.controller2,
    required this.fields,
  });

  @override
  State<TodoFields> createState() => _TodoFieldsState();
}

class _TodoFieldsState extends State<TodoFields> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, context.percentHeight(.04), 0, 0),
          child: Form(
            key: widget.formKey,
            child: ListView(children: fields(widget.fields)),
          ),
        ),
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
                  widget.controller1,
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
                  widget.controller2,
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
