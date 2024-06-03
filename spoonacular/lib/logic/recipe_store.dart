import 'package:mobx/mobx.dart';
import 'package:spoonacular/models/cart_item.dart';
import 'package:spoonacular/models/recipe_isar.dart';
import 'package:spoonacular/repository/local_storage.dart';
import '../models/recipe_item.dart';
import '../repository/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'recipe_store.g.dart';

class RecipeStore = _RecipeStore with _$RecipeStore;

abstract class _RecipeStore with Store {
  final _apiService = ApiService(dotenv.env['apiKey']!);

  @observable
  ObservableList<Recipe> recipes = ObservableList<Recipe>();

  @observable
  ObservableList<CartItem> cartItems = ObservableList<CartItem>();

  @action
  Future<void> storeRecipesToIsar() async {
    _apiService.fetchFoodItems();
    //await LocalStorage.storeRecipesIfEmpty(fetchedRecipes);
    //recipes.addAll(fetchedRecipes);
  }

  @action
  void addToCart(CartItem item) {
    final index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      final existingItem = cartItems[index];
      final updatedItem = CartItem(
        id: existingItem.id,
        name: existingItem.name,
        image: existingItem.image,
        count: existingItem.count + 1,
      );
      cartItems[index] = updatedItem;
    } else {
      cartItems.add(item);
    }
  }

  @action
  void removeFromCart(int id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final selectedItem = cartItems[index];
      if (selectedItem.count > 1) {
        final updatedItem = CartItem(
          id: selectedItem.id,
          name: selectedItem.name,
          image: selectedItem.image,
          count: selectedItem.count - 1,
        );
        cartItems[index] = updatedItem;
      } else {
        cartItems.removeAt(index);
      }
    }
  }
}
