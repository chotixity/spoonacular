import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/recipe_isar.dart';
import '../models/recipe_item.dart';
import '../models/cart_isar.dart';

class LocalStorage {
  static late Isar isar;

  static Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [RecipeIsarSchema, CartItemIsarSchema],
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
  //   await isar.writeTxn(() async {
  //     final existingItem =
  //       await isar.cartItemIsars.where().filter().nameEqualTo(value)
  //     if (existingItem != null) {
  //       existingItem.count++;
  //       await isar.cartItemIsars.put(existingItem);
  //     } else {
  //       final cartItem = CartItemIsar()
  //         ..id = recipe.id
  //         ..name = recipe.title
  //         ..image = recipe.image
  //         ..count = 1;
  //       await isar.cartItemIsars.put(cartItem);
  //     }
  //   });
  // }

  // static Future<void> removeFromCart(String id) async {
  //   await isar.writeTxn(() async {
  //     final existingItem =
  //         await isar.cartItemIsars.filter().idEqualTo(id).findFirst();
  //     if (existingItem != null) {
  //       if (existingItem.count > 1) {
  //         existingItem.count--;
  //         await isar.cartItemIsars.put(existingItem);
  //       } else {
  //         await isar.cartItemIsars.delete(existingItem.isarId!);
  //       }
  //     }
  //   });
  // }

  // static Future<List<Checkout>> getCheckoutHistory() async {
  //   return await isar.checkouts.where().findAll();
  // }
}
