import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/item.dart';

class ItemService {
  static Future<List<Item>> loadItems() async {
    final String response = await rootBundle.loadString('lib/data/items.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Item.fromJson(json)).toList();
  }

  static Future<List<Item>> getCarouselItems() async {
    final List<Item> allItems = await loadItems();
    return allItems.where((item) => item.onCarousel).toList();
  }
}
