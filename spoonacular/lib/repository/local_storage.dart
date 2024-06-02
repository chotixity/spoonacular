import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/recipe_isar.dart';
import '../models/food_item.dart';

class LocalStorage {
  static late Isar isar;

  static Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        RecipeIsarSchema,
      ],
      directory: dir.path,
    );
  }

  static Future<void> storeRecipesIfEmpty(List<Recipe> recipes) async {
    final count = await isar.recipeIsars.count();
    if (count == 0) {
      await isar.writeTxn(() async {
        for (var recipe in recipes) {
          await isar.recipeIsars.put(RecipeIsar.fromRecipe(recipe));
        }
      });
    }
  }

  static Future<List<Recipe>> getRecipes() async {
    final items = await isar.recipeIsars.where().findAll();
    debugPrint("I have fetched the items");
    return items.map((isarRecipe) => isarRecipe.toRecipe()).toList();
  }

  // static Future<void> addToCart(Recipe recipe) async {
  //   final cartItem = CartItem()
  //     ..id = recipe.id
  //     ..title = recipe.title
  //     ..image = recipe.image;

  //   await isar.writeTxn(() async {
  //     await isar.cartItems.put(cartItem);
  //   });
  // }

  // static Future<void> removeFromCart(String id) async {
  //   await isar.writeTxn(() async {
  //     await isar.cartItems.where().idEqualTo(id).deleteFirst();
  //   });
  // }

  // static Future<List<Recipe>> getCartItems() async {
  //   final items = await isar.cartItems.where().findAll();
  //   return items.map((cartItem) => cartItem.toRecipe()).toList();
  // }

  // static Future<void> checkout() async {
  //   final cartItems = await getCartItems();
  //   if (cartItems.isNotEmpty) {
  //     final checkout = Checkout()
  //       ..timestamp = DateTime.now()
  //       ..items = cartItems.map((item) => RecipeIsar.fromRecipe(item)).toList();

  //     await isar.writeTxn(() async {
  //       await isar.checkouts.put(checkout);
  //       await isar.cartItems.where().deleteAll();
  //     });
  //   }
  // }

  // static Future<List<Checkout>> getCheckoutHistory() async {
  //   return await isar.checkouts.where().findAll();
  // }
}
