import 'package:flutter/material.dart';

import '../styles/app_styles.dart';
import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaulInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: Colors.grey.shade300),
    // borderSide: BorderSide(color: Colors.transparent),
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: ColorsApp.i.background,
    drawerTheme: const DrawerThemeData(
      scrimColor: Colors.transparent,
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      titleTextStyle:
          TextStyles.i.textMedium.copyWith(fontSize: 18, color: Colors.white),
      backgroundColor: ColorsApp.i.primary,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    primaryColor: ColorsApp.i.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.i.primary,
      primary: ColorsApp.i.primary,
      secondary: ColorsApp.i.secondary,
    ),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: AppStyles.i.primaryButton),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(13),
      border: _defaulInputBorder,
      enabledBorder: _defaulInputBorder,
      focusedBorder: _defaulInputBorder,
      labelStyle: TextStyles.i.textRegular.copyWith(color: Colors.black),
      errorStyle: TextStyles.i.textRegular.copyWith(color: Colors.redAccent),
    ),
  );
}
