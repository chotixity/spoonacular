import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/recipe_item.dart';
import '../models/recipe_isar.dart';
import '../models/cart_isar.dart';
import '../models/cart_item.dart';

class LocalStorage {
  static late Isar isar;

  static Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [RecipeIsarSchema, CartItemIsarSchema],
      directory: dir.path,
    );
  }

  static Future<void> storeRecipesIfEmpty(List<RecipeIsar> recipes) async {
    final count = await isar.recipeIsars.count();
    if (count == 0) {
      await isar.writeTxn(() async {
        for (var recipe in recipes) {
          await isar.recipeIsars.put(recipe);
        }
      });
    }
  }

  static Future<List<Recipe>> getRecipes() async {
    final items = await isar.recipeIsars.where().findAll();
    debugPrint("I have fetched the items");
    return items.map((isarRecipe) => isarRecipe.toRecipe()).toList();
  }

  static Future<void> addToCart(CartItem cartItem) async {
    await isar.writeTxn(() async {
      final existingItem =
          await isar.cartItemIsars.filter().idEqualTo(cartItem.id).findFirst();
      if (existingItem != null) {
        existingItem.count++;
        await isar.cartItemIsars.put(existingItem);
      } else {
        final newItem = CartItemIsar()
          ..id = cartItem.id
          ..name = cartItem.name
          ..image = cartItem.image
          ..count = cartItem.count;
        await isar.cartItemIsars.put(newItem);
      }
    });
  }

  static Future<void> removeFromCart(int id) async {
    await isar.writeTxn(() async {
      final existingItem =
          await isar.cartItemIsars.filter().idEqualTo(id).findFirst();
      await isar.cartItemIsars.delete(existingItem!.isarId!);
      // if (existingItem != null) {
      //   if (existingItem.count > 1) {
      //     existingItem.count--;
      //     await isar.cartItemIsars.put(existingItem);
      //   } else {
      //     await isar.cartItemIsars.delete(existingItem.isarId!);
      //   }
      // }
    });
  }

  static Future<List<CartItem>> getCartItems() async {
    final items = await isar.cartItemIsars.where().findAll();
    return items
        .map((isarCartItem) => CartItem(
              id: isarCartItem.id,
              name: isarCartItem.name,
              image: isarCartItem.image,
              count: isarCartItem.count,
            ))
        .toList();
  }

  static Future<void> clearCart() async {
    await isar.writeTxn(() async {
      await isar.cartItemIsars.clear();
    });
  }
}
