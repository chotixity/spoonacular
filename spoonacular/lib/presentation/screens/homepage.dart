import 'package:flutter/material.dart';
import 'package:spoonacular/models/recipe_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../models/recipe_item.dart';
import '../../models/cart_item.dart';
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
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _recipeStore.storeRecipesToIsar();
    _initializeRecipes();
  }

  Future<void> _initializeRecipes() async {
    final recipes = await LocalStorage.getRecipes();
    setState(() {
      _recipeStore.recipes = ObservableList<Recipe>.of(recipes);
      _selectedItems = List<bool>.filled(recipes.length, false);
    });
  }

  void _toggleSelection(int index, Recipe recipe) {
    setState(() {
      _selectedItems[index] = !_selectedItems[index];
    });
    if (_selectedItems[index]) {
      _addToCart(recipe);
    } else {
      // Assuming you have a method to remove items from the cart
      _recipeStore.removeFromCart(recipe.id);
    }
  }

  Future<void> _addToCart(Recipe recipe) async {
    final cartItem = CartItem(
      id: recipe.id,
      name: recipe.title,
      image: recipe.image,
      count: 1,
    );
    await _recipeStore.addToCart(cartItem);
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        recipeStore: _recipeStore,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart_checkout,
                ),
              ),
            );
          })
        ],
      ),
      body: Observer(builder: (_) {
        if (_recipeStore.recipes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            itemCount: _recipeStore.recipes.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 480,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final recipe = _recipeStore.recipes[index];
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: GestureDetector(
                  onTap: () {
                    _toggleSelection(index, recipe);
                  },
                  child: GridTile(
                    header: IconButton(
                      onPressed: () {
                        _toggleSelection(index, recipe);
                      },
                      icon: _selectedItems[index]
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                            ),
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black45,
                      title: Text(
                        recipe.title,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          _addToCart(recipe);
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                        ),
                      ),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: recipe.image,
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
