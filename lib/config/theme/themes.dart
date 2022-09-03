import 'package:flutter/material.dart';

abstract class Themes {
  const Themes._();

  static ThemeData get lightTheme {
    return ThemeData.light();
  }

  static ThemeData get darkTheme {
    return ThemeData.dark();
  }
}
