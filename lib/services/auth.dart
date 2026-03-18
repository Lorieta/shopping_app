import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> signUp({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String region,
    required String province,
    required String municipality,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', firstName);
      await prefs.setString('lastName', lastName);
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      await prefs.setString('region', region);
      await prefs.setString('province', province);
      await prefs.setString('municipality', municipality);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedUsername = prefs.getString('username');
      final savedPassword = prefs.getString('password');

      if (savedUsername == null || savedPassword == null) {
        return false;
      }

      return username == savedUsername && password == savedPassword;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedUsername = prefs.getString('username');
      final savedPassword = prefs.getString('password');
      return savedUsername != null && savedPassword != null;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'firstName': prefs.getString('firstName'),
      'lastName': prefs.getString('lastName'),
      'username': prefs.getString('username'),
      'region': prefs.getString('region'),
      'province': prefs.getString('province'),
      'municipality': prefs.getString('municipality'),
      'profile_image_path': prefs.getString('profile_image_path'),
    };
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('region');
    await prefs.remove('province');
    await prefs.remove('municipality');
  }
}
