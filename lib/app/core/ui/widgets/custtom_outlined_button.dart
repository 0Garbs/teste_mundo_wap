import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/colors_app.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

class CusttomOutlinedButton extends StatelessWidget {
  final String label;
  final Icon? icon;
  final double? fontSize;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  const CusttomOutlinedButton({
    super.key,
    required this.label,
    this.icon,
    this.fontSize = 16.0,
    this.onPressed,
    this.width,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            side: BorderSide(width: 1, color: context.colors.primary),
            backgroundColor: Colors.white),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: context.textStyles.textMedium
                        .copyWith(fontSize: fontSize),
                  )
                ],
              )
            : Text(
                label,
                style:
                    context.textStyles.textMedium.copyWith(fontSize: fontSize),
              ),
      ),
    );
  }
}
