import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;
  // Avoid self instance
  TextStyles._();
  static TextStyles get i => _instance ??= TextStyles._();

  TextStyle get textLight => TextStyle(fontWeight: FontWeight.w300);

  TextStyle get textRegular => TextStyle(fontWeight: FontWeight.normal);

  TextStyle get textMedium => TextStyle(fontWeight: FontWeight.w500);

  TextStyle get textSemiBold => TextStyle(fontWeight: FontWeight.w600);

  TextStyle get textBold => TextStyle(fontWeight: FontWeight.bold);

  TextStyle get textExtraBold => TextStyle(fontWeight: FontWeight.w800);

  TextStyle get textButtonStyle => textMedium.copyWith(fontSize: 14);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
