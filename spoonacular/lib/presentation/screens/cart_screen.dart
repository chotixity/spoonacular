import 'package:flutter/material.dart';
import '../../models/food_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Recipe> cartItems = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('No items in the cart Yet'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(cartItems[index].image),
                );
              },
            ),
    );
  }
}
