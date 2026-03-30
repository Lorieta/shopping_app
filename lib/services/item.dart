import '../models/item.dart';
import './database.dart';

class ItemService {
  static DatabaseHelper dbhelper = DatabaseHelper();

  static Future<List<Item>?> loadItems() async {
    final db = await dbhelper.database;
    try {
      String sql = "SELECT * FROM items";
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);

      List<Item> itemlist = results
          .map((itemMap) => Item.fromMap(itemMap))
          .toList();

      return itemlist;
    } catch (err) {
      return null;
    }
  }

  static Future<List<Item>> getCarouselItems() async {
    final List<Item> allItems = await loadItems().then((items) => items ?? []);
    return allItems.where((item) => item.onCarousel).toList();
  }
}
