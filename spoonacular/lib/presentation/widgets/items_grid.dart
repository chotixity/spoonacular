import 'package:flutter/material.dart';

class ItemsGrid extends StatefulWidget {
  final String imageUrl;
  final String title;
  const ItemsGrid({required this.imageUrl, required this.title, super.key});

  @override
  State<ItemsGrid> createState() => _ItemsGridState();
}

class _ItemsGridState extends State<ItemsGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 480),
      itemBuilder: (context, index) {
        return GridTile(
          footer: Row(
            children: [
              Text(widget.title),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              )
            ],
          ),
          child: Image.network(widget.imageUrl),
        );
      },
    );
  }
}
