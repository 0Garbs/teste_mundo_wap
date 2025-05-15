import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

enum CustomTextFieldType { date, weekDate, fullWeekDate, time }

class CustomTextField extends StatefulWidget {
  final bool showicon;
  final TextEditingController controller;
  final bool isEditable;
  final CustomTextFieldType type;
  final bool hasPastAcess;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomTextField({
    super.key,
    // this.label = '',
    this.showicon = false,
    required this.controller,
    this.isEditable = true,
    required this.type,
    this.hasPastAcess = true,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final IconData icon = CustomSettings.selectIcon(widget.type);

    // final String label = widget.label;

    return TextField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        icon: widget.showicon ? Icon(icon, color: Colors.black54) : null,
        filled: true,
        fillColor: widget.isEditable ? Colors.grey[300] : Colors.grey[400],
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      ),
      style: context.textStyles.textMedium,
      onTap: () async => await CustomMethods.showDateOrTimePicker(
        isEditable: widget.isEditable,
        type: widget.type,
        hasPastAcess: widget.hasPastAcess,
        givenDate: widget.initialDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        controller: widget.controller,
        context: context,
      ).then((value) => setState(() {})),
    );
  }
}

class CustomMethods {
  static DateTime weekDateToDateTime({required String controllerText}) {
    List<String> weekDayAndDate = controllerText.split(' ');
    return simpleDateToDateTime(controllerText: weekDayAndDate.last);
  }

  static DateTime simpleDateToDateTime({required String controllerText}) {
    List<String> partsOfDateBySlash = controllerText.split('/');

    final int ano = int.parse(partsOfDateBySlash[2]);
    final int mes = int.parse(partsOfDateBySlash[1]);
    final int dia = int.parse(partsOfDateBySlash[0]);
    return DateTime(ano, mes, dia);
  }

  static Future showDateOrTimePicker({
    required bool isEditable,
    required CustomTextFieldType type,
    required bool hasPastAcess,
    required TextEditingController controller,
    required BuildContext context,
    DateTime? givenDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    if (isEditable) {
      final intl.DateFormat formatter = CustomSettings.selectFormat(type);
      if (CustomSettings.selectPicker(type)) {
        return await showDatePick(
          hasPastAcess: hasPastAcess,
          controller: controller,
          context: context,
          format: formatter,
          givenDate: givenDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime.now(),
          lastDate: lastDate ?? DateTime.now().add(const Duration(days: 1095)),
        );
      } else {
        return await showTimePick(
          controller: controller,
          context: context,
        );
      }
    }
    return null;
  }

  static Future showDatePick({
    required bool hasPastAcess,
    required TextEditingController controller,
    required BuildContext context,
    required intl.DateFormat format,
    required DateTime givenDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      initialDate: givenDate,
      keyboardType: TextInputType.none,
      switchToInputEntryModeIcon: const Icon(Icons.highlight_remove_outlined),
      onDatePickerModeChange: (_) {
        Navigator.of(context).pop();
      },
      locale: const Locale('pt', 'BR'),
      context: context,
      firstDate: hasPastAcess ? firstDate : DateTime.now(),
      lastDate: lastDate,
    );

    if (picked != null) {
      controller.text = format.format(picked);
    }
  }

  static Future showTimePick({
    required TextEditingController controller,
    required BuildContext context,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      helpText: 'Insira um horário',
      hourLabelText: 'Horário',
      minuteLabelText: 'Minutos',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            ),
          ),
        );
      },
    );

    if (picked != null) {
      final String hours =
          picked.hour < 10 ? '0${picked.hour}' : picked.hour.toString();

      final String minutes =
          picked.minute < 10 ? '0${picked.minute}' : picked.minute.toString();
      controller.text = '$hours:$minutes';
    }
  }
}

class CustomSettings {
  static intl.DateFormat selectFormat(CustomTextFieldType type) {
    switch (type) {
      case CustomTextFieldType.date:
        return intl.DateFormat('dd/MM/yyyy');
      case CustomTextFieldType.weekDate:
        return intl.DateFormat("d 'de' MMMM 'de' y", 'pt_BR');
      case CustomTextFieldType.fullWeekDate:
        return intl.DateFormat('EEEE, dd MMM yyyy', 'pt_BR');
      default:
        return intl.DateFormat('Hm');
    }
  }

  static IconData selectIcon(CustomTextFieldType type) {
    switch (type) {
      case CustomTextFieldType.fullWeekDate ||
            CustomTextFieldType.weekDate ||
            CustomTextFieldType.date:
        return Icons.event;
      default:
        return Icons.event;
    }
  }

  static bool selectPicker(CustomTextFieldType type) {
    switch (type) {
      case CustomTextFieldType.fullWeekDate ||
            CustomTextFieldType.weekDate ||
            CustomTextFieldType.date:
        return true;
      default:
        return false;
    }
  }
}
