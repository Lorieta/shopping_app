import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import '../classes/logger.dart';

enum ThemeEnum { Dark, Light }

class ThemeProvider extends ChangeNotifier {
  ThemeEnum currentTheme = ThemeEnum.Light;
  ThemeData? currentThemeData;

  static ThemeProvider? _instance;

  static ThemeProvider get instance {
    _instance ??= ThemeProvider._init();
    return _instance!;
  }

  ThemeProvider._init();

  Future<void> changeTheme(ThemeEnum theme) async {
    try {
      currentTheme = theme;
      await _generateThemeData();
      notifyListeners();
    } on Exception catch (e) {
      AppLogger.logger.d(e);
    }
  }

  Future<void> _generateThemeData() async {
    try {
      String themeStr = await rootBundle.loadString(_getThemeJsonPath());
      Map<String, dynamic> themeJson = _castJson(
        Map<String, dynamic>.from(jsonDecode(themeStr)),
      );
      currentThemeData = ThemeDecoder().decodeThemeData(themeJson);
    } catch (e) {
      AppLogger.logger.d('Error: $e');
      currentThemeData = ThemeData.light();
    }
  }

  Map<String, dynamic> _castJson(Map<String, dynamic> map) {
    try {
      return map.map((key, value) {
        if (value is Map<String, dynamic>) {
          return MapEntry(key, _castJson(value));
        } else if (value is Map) {
          return MapEntry(key, _castJson(Map<String, dynamic>.from(value)));
        } else if (value is List) {
          // Cast string lists (e.g. fontFamilyFallback) properly
          if (value.every((e) => e is String)) {
            return MapEntry(key, List<String>.from(value));
          }
        }
        return MapEntry(key, value);
      });
    } on Exception catch (e) {
      AppLogger.logger.d('Error: $e');
      return {};
    }
  }

  String _getThemeJsonPath() {
    switch (currentTheme) {
      case ThemeEnum.Light:
        return "lib/assets/themes/light_theme.json";
      case ThemeEnum.Dark:
        return "lib/assets/themes/dark_theme.json";
    }
  }
}
