import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spoonacular/logic/recipe_store.dart';
import '../../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  final RecipeStore recipeStore;

  const CartScreen({required this.recipeStore, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out'),
      ),
      body: Observer(
        builder: (_) {
          final cartItems = recipeStore.cartItems;
          if (cartItems.isEmpty) {
            return const Center(child: Text('No items in the cart Yet'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return Dismissible(
                          key: Key(cartItem.id.toString()),
                          onDismissed: (direction) {
                            recipeStore.removeFromCart(cartItem.id);
                          },
                          background: Container(color: Colors.red),
                          child: ListTile(
                            leading: Image.network(cartItem.image),
                            title: Text(cartItem.name),
                            subtitle: Text('Quantity: ${cartItem.count}'),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Checkout'),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
