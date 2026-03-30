import 'package:shared_preferences/shared_preferences.dart';
import 'database.dart';
import '../models/user.dart';

class AuthService {
  static DatabaseHelper dbHelper = DatabaseHelper();

  static Future<bool> registerUser(User user) async {
    try {
      String sql =
          "INSERT INTO users (firstName, lastName, username, password, region, province,  municipality) VALUES (?, ?, ?, ?, ?, ?, ?)";
      final id = await dbHelper.database;
      id.rawInsert(sql, [
        user.firstName,
        user.lastName,
        user.username,
        user.password,
        user.region,
        user.province,
        user.municipality,
      ]);

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
    var result = await db.rawQuery(
      "SELECT * FROM users WHERE username = ? and password = ?",
      [username, password],
    );

    if (result.isNotEmpty) {
      return User.fromMap(Map<String, dynamic>.from(result.first));
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

        return User(
          id: userData['id'] as int,
          firstName: userData['firstName']?.toString() ?? '',
          lastName: userData['lastName']?.toString() ?? '',
          username: userData['username']?.toString() ?? '',
          password: userData['password']?.toString() ?? '',
          region: userData['region']?.toString() ?? '',
          province: userData['province']?.toString() ?? '',
          municipality: userData['municipality']?.toString() ?? '',
        );
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

  /** 
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
  */
}
