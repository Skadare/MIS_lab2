import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/models/meal_model.dart';
import 'package:lab2/models/meal_summary_model.dart';
import 'package:lab2/models/category_model.dart';


class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> loadCategories() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/categories.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['categories'] ?? [];

      return list
          .map((json) => Category.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  Future<List<MealSummary>> loadMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$_baseUrl/filter.php?c=$category'),);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['meals'] ?? [];

      return list
          .map((json) => MealSummary.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  Future<Meal?> loadMealById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$id'),);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['meals'] ?? [];
      if (list.isEmpty) return null;

      return Meal.fromJson(list.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<Meal?> loadRandomMeal() async {
    final response = await http.get(Uri.parse('$_baseUrl/random.php'),);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> list = data['meals'] ?? [];
      if (list.isEmpty) return null;

      return Meal.fromJson(list.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<List<MealSummary>> searchMealsByName(String query) async {
    if (query.isEmpty) return [];

    final response = await http.get(Uri.parse('$_baseUrl/search.php?s=$query'),);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic>? list = data['meals'];

      if (list == null) return [];

      return list
          .map((json) => MealSummary.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
