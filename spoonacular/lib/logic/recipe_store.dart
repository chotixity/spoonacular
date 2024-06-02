import 'package:mobx/mobx.dart';
import 'package:spoonacular/models/recipe_isar.dart';
import 'package:spoonacular/repository/local_storage.dart';
import '../models/food_item.dart';
import '../repository/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecipeStore with Store {
  final _apiService = ApiService(dotenv.env['apiKey']!);
  @observable
  ObservableList<Recipe> recipes = ObservableList<Recipe>();

  @observable
  ObservableList<Recipe> cartItems = ObservableList<Recipe>();

  @action
  void storeRecipestoIsar() {
    _apiService.fetchFoodItems();
    // LocalStorage.storeRecipesIfEmpty(_apiService.recipeItems);
  }

  @action
  void addToCart(Recipe recipe) {
    cartItems.add(recipe);
  }

  @action
  void removeFromCart(Recipe recipe) {
    cartItems.remove(recipe);
  }
}
