import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_app/models/item.dart';
import '../classes/logger.dart';

class ItemService {
  final http.Client client;
  ItemService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Item>> fetchData() async {
    try {
      final String url =
          'https://dummyjson.com/products?limit=30&skip=0&select=title,price,thumbnail,description,image,category';
      final response = await client.get(Uri.parse(url));
      final List<dynamic> request = jsonDecode(response.body)['products'];

      List<Item> itemlist = request
          .map((itemMap) => Item.fromJson(itemMap as Map<String, dynamic>))
          .toList();

      return itemlist;
    } on Exception catch (e) {
      AppLogger.logger.d(e);
      return [];
    }
  }

  Future<List<Item>> filterItems(String url) async {
    try {
      final response = await client.get(Uri.parse(url));
      final List<dynamic> request = jsonDecode(response.body)['products'];

      List<Item> itemlist = request
          .map((itemMap) => Item.fromJson(itemMap as Map<String, dynamic>))
          .toList();
      return itemlist;
    } catch (e) {
      AppLogger.logger.d(e);
      return [];
    }
  }
}
