import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spoonacular/logic/recipe_store.dart';
import '../../models/recipe_item.dart';

class CartScreen extends StatelessWidget {
  final RecipeStore _recipeStore = RecipeStore();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out'),
      ),
      body: Observer(
        builder: (_) {
          if (_recipeStore.cartItems.isEmpty) {
            return const Center(child: Text('No items in the cart Yet'));
          } else {
            return ListView.builder(
              itemCount: _recipeStore.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = _recipeStore.cartItems[index];
                return Dismissible(
                  key: Key(cartItem.id
                      .toString()), // Ensure unique key for each item
                  onDismissed: (direction) {
                    // Handle item dismissal
                    _recipeStore.removeFromCart(cartItem.id);
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    leading: Image.network(cartItem.image),
                    title: Text(cartItem.name),
                    subtitle: Text('Quantity: ${cartItem.count}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
