import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:spoonacular/models/recipe_item.dart';
import 'package:spoonacular/repository/local_storage.dart';
import '../models/recipe_isar.dart';

class ApiService {
  final String apiKey;
  final String baseUrl = 'api.spoonacular.com';
  ApiService(this.apiKey);

  Future<void> fetchFoodItems() async {
    final url = Uri.https(baseUrl, '/recipes/random', {
      'apiKey': apiKey,
      'number': '40',
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> recipes = data['recipes'];
      List<RecipeIsar> recipeItems = recipes
          .map((item) => RecipeIsar.fromRecipe(Recipe.fromJson(item)))
          .toList();
      await LocalStorage.storeRecipesIfEmpty(recipeItems);
    } else {
      throw Exception('Failed to load food items');
    }
  }
}
