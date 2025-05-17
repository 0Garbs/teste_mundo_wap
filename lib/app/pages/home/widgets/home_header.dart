import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/colors_app.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

class HomeHeader extends StatelessWidget {
  final String? name;
  final int qtyTodo;

  const HomeHeader({super.key, required this.name, required this.qtyTodo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60.0,
          width: 60.0,
          child: ClipOval(
            child: CircleAvatar(
              backgroundColor: context.colors.secondary,
              child: Icon(Icons.person, size: 35),
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getName(name),
              style: context.textStyles.textBold.copyWith(fontSize: 26.0),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '$qtyTodo Tarefas',
              style: context.textStyles.textSemiBold.copyWith(fontSize: 15.0),
            ),
          ],
        ),
      ],
    );
  }

  String getName(String? name) {
    if (name == null) {
      return '';
    }

    if (!name.contains(' ')) {
      return name;
    }

    return name.split(' ').first;
  }
}
