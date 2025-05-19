import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/colors_app.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double? fontSize;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool enabled;

  const CustomButton({
    super.key,
    required this.label,
    this.fontSize = 18.0,
    required this.onPressed,
    this.width,
    this.height = 50.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? context.colors.primary : const Color(0xFFDCDCDC),
        ),
        onPressed: enabled ? onPressed : () {},
        child: Text(
          label,
          style: context.textStyles.textButtonStyle.copyWith(
            color: enabled ? Colors.white : Colors.black54,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
