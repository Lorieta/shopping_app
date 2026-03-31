import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

enum ThemeEnum { Dark, Light }

class ThemeProvider extends ChangeNotifier {
  ThemeEnum currentTheme = ThemeEnum.Light;
  ThemeData? currentThemeData;

  static ThemeProvider? _instance;
}
