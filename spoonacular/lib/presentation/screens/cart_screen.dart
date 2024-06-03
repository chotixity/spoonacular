import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spoonacular/models/recipe_store.dart';
import 'package:spoonacular/presentation/screens/success_checkout.dart';
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
                            trailing: IconButton(
                              onPressed: () {
                                recipeStore.removeFromCart(cartItem.id);
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      recipeStore.checkout();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SuccessCheckout()));
                    },
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
