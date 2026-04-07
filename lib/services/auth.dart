import 'package:shared_preferences/shared_preferences.dart';
import '../classes/database.dart';
import '../models/user.dart';

class AuthService {
  static DatabaseHelper dbHelper = DatabaseHelper.instance;

  static Future<bool> registerUser(User user) async {
    try {
      final id = await dbHelper.database;
      await id.insert('users', user.toMap());
      return true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<User?> login({
    required String username,
    required String password,
  }) async {
    final db = await dbHelper.database;
    try {
      var result = await db.rawQuery(
        "SELECT * FROM users WHERE username = ? and password = ?",
        [username, password],
      );

      if (result.isNotEmpty) {
        return User.fromMap(Map<String, dynamic>.from(result.first));
      }
    } catch (err) {
      return null;
    }
    return null;
  }

  static Future<User?> getUserData(int id) async {
    try {
      final db = await dbHelper.database;
      final sql = "SELECT * FROM users WHERE id= ?";
      var result = await db.rawQuery(sql, [id]);
      if (result.isNotEmpty) {
        final userData = result.first;
        return User.fromMap(Map<String, dynamic>.from(userData));
      }
      return null;
    } catch (e) {
      return null;
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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('region');
    await prefs.remove('province');
    await prefs.remove(' municipality');
  }
}
