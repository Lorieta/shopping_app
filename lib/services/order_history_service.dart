import 'package:shopping_app/models/order_history.dart';

import '../classes/database.dart';
import '../classes/logger.dart';

class OrderHistoryService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<bool> addHistory(OrderHistory order) async {
    try {
      final db = await dbHelper.database;
      await db.insert('orderHistoryTable', order.toMap());
      return true;
    } catch (err) {
      AppLogger.logger.d('Error: $err');
      return false;
    }
  }

  Future<List<OrderHistory>?> loadHistory() async {
    final db = await dbHelper.database;
    try {
      String sql = "SELECT * FROM orderHistoryTable";
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);
      List<OrderHistory> historylist = results
          .map((historymap) => OrderHistory.fromMap(historymap))
          .toList();
      return historylist;
    } catch (err) {
      AppLogger.logger.d('Error: $err');
      return [];
    }
  }
}
