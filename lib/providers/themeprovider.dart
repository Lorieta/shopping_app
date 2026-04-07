import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

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
    currentTheme = theme;
    await _generateThemeData();
    notifyListeners();
  }

  Future<void> _generateThemeData() async {
    try {
      String themeStr = await rootBundle.loadString(_getThemeJsonPath());
      Map<String, dynamic> themeJson = _castJson(
        Map<String, dynamic>.from(jsonDecode(themeStr)),
      );
      currentThemeData = ThemeDecoder().decodeThemeData(themeJson);
    } catch (e) {
      debugPrint('Theme load failed: $e');
      currentThemeData = ThemeData.light();
    }
  }

  Map<String, dynamic> _castJson(Map<String, dynamic> map) {
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
  }

  String _getThemeJsonPath() {
    switch (currentTheme) {
      case ThemeEnum.Light:
        return "lib/assets/themes/light_theme.json";
      case ThemeEnum.Dark:
        return "lib/assets/themes/dark_theme.json";
      default:
        return "/lib/assets/themes/light_theme.json";
    }
  }
}
