import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  // Avoid self instance
  ColorsApp._();
  static ColorsApp get i => _instance ??= ColorsApp._();

  Color get primary => const Color(0xFF263868);
  Color get secondary => const Color(0xFF336699);
  Color get background => const Color(0xFFF1F2F4);
  Color get backgroundApp => const Color.fromARGB(255, 226, 226, 226);
  Color get greyText => const Color(0xFF49454F);
  Color get greyIcon => const Color(0xFF494C4F);
}

extension ColorAppExtension on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}
