import 'package:flutter/material.dart';

import 'colors_app.dart';
import 'text_styles.dart';

class AppStyles {
  static AppStyles? _instance;
  // Avoid self instance
  AppStyles._();
  static AppStyles get i => _instance ??= AppStyles._();

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: ColorsApp.i.primary,
        textStyle: TextStyles.i.textButtonStyle,
      );
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}