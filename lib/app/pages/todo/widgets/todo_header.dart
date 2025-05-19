import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

class TodoHeader extends StatelessWidget {
  final String title;
  final String description;

  const TodoHeader({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textStyles.textBold.copyWith(fontSize: 28)),
        SizedBox(height: 10),
        Text(
          description,
          style: context.textStyles.textSemiBold.copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
