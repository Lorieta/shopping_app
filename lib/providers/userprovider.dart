import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth.dart';

class UserProvider extends ChangeNotifier {
  int? _id;
  Map<String, dynamic>? _user;
  bool _isLoggedIn = false;

  // Add these getters
  int? get id => _id;
  Map<String, dynamic>? get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(
    String username,
    String password, {
    bool rememberMe = false,
  }) async {
    var login = await AuthService.login(username: username, password: password);

    if (login != null) {
      _id = login.id;
      _user = login.toMap();
      _isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setInt('id', _id!);
        await prefs.setString('user', jsonEncode(_user));
      } else {
        // Clear any existing saved session if not remembering
        await prefs.remove('id');
        await prefs.remove('user');
      }

      notifyListeners();
      return _isLoggedIn;
    } else {
      return false;
    }
  }

  Future<void> getinfo(int id) async {
    var info = await AuthService.getUserData(id);

    if (info != null) {
      _id = id;
      _user = info.toMap();

      final prefsInfo = await SharedPreferences.getInstance();
      await prefsInfo.setString('user', jsonEncode(_user));

      notifyListeners();
    }
  }

  Future<void> restoreSession() async {
    final pref = await SharedPreferences.getInstance();
    final savedId = pref.getInt('id');

    if (savedId != null) {
      await getinfo(savedId);
      _isLoggedIn = true;
      notifyListeners();
    }
  }
}
