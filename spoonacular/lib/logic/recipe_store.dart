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
    await _apiService.fetchFoodItems();
    final storedRecipes = await LocalStorage.getRecipes();
    recipes = ObservableList<Recipe>.of(storedRecipes);
  }

  @action
  Future<void> addToCart(CartItem cartItem) async {
    await LocalStorage.addToCart(cartItem);
    await _updateCartItems();
    print(cartItems);
  }

  @action
  Future<void> removeFromCart(int id) async {
    await LocalStorage.removeFromCart(id);
    await _updateCartItems();
  }

  @action
  Future<void> _updateCartItems() async {
    final cartItemsList = await LocalStorage.getCartItems();
    print('This is the cart Item List $cartItemsList');
    cartItems = ObservableList<CartItem>.of(cartItemsList);
  }
}
