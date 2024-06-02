import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:spoonacular/logic/recipe_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../models/food_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spoonacular/presentation/screens/cart_screen.dart';
import 'package:spoonacular/repository/local_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final RecipeStore _recipeStore = RecipeStore();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recipeStore.storeRecipestoIsar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        actions: [
          Observer(builder: (_) {
            return Badge.count(
              alignment: Alignment.topCenter,
              count: _recipeStore.cartItems.length,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CartScreen()));
                },
                icon: const Icon(
                  Icons.shopping_cart_checkout,
                ),
              ),
            );
          })
        ],
      ),
      body: FutureBuilder(
        future: LocalStorage.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Recipe> data = snapshot.data!;
            print(data);
            return GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 480,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: GridTile(
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text(
                            data[index].title,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _recipeStore.addToCart(data[index]);
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart,
                          ),
                        )
                      ],
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: data[index].image,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Aw, Snap! An eroor occured');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
