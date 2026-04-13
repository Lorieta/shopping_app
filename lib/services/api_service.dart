import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_app/models/item.dart';
import '../models/categories.dart';
import '../classes/logger.dart';

class ApiService {
  final http.Client client;
  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Item>> fetchData() async {
    try {
      // 1. Define your target categories
      final List<String> categories = [
        'laptops',
        'smartphones',
        'tablets',
        'mobile-accessories',
      ];

      List<Item> itemlist = [];

      // 2. Loop through each category and fetch data
      for (String category in categories) {
        final String url =
            'https://dummyjson.com/products/category/$category?select=title,price,thumbnail,description,image,category';

        final response = await client.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final List<dynamic> productsJson = jsonDecode(
            response.body,
          )['products'];

          // 3. Map and add to our master list
          final List<Item> categoryItems = productsJson
              .map((itemMap) => Item.fromJson(itemMap as Map<String, dynamic>))
              .toList();

          itemlist.addAll(categoryItems);
        }
      }

      return itemlist;
    } on Exception catch (e) {
      AppLogger.logger.d('Error: $e');
      return [];
    }
  }

  Future<List<Categories>> getCategories() async {
    try {
      final String url = "https://dummyjson.com/products/categories";

      final response = await client.get(Uri.parse(url));

      final List<dynamic> request = jsonDecode(response.body);

      List<Categories> categoryList = request
          .map(
            (categoryMap) =>
                Categories.fromJson(categoryMap as Map<String, dynamic>),
          )
          .toList();
      return categoryList;
    } on Exception catch (e) {
      AppLogger.logger.d('Error: $e');
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
      AppLogger.logger.d('Error: $e');
      return [];
    }
  }
}
