import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_app/models/meal.dart';

class MealService {
  final String url = "";

  Future<List<Meal>?> getAllMeal() async {
    final res = await http.get(Uri.parse(url));
  }
}
