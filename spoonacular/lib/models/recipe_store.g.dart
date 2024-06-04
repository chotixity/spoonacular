// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecipeStore on _RecipeStore, Store {
  late final _$recipesAtom =
      Atom(name: '_RecipeStore.recipes', context: context);

  @override
  ObservableList<Recipe> get recipes {
    _$recipesAtom.reportRead();
    return super.recipes;
  }

  @override
  set recipes(ObservableList<Recipe> value) {
    _$recipesAtom.reportWrite(value, super.recipes, () {
      super.recipes = value;
    });
  }

  late final _$cartItemsAtom =
      Atom(name: '_RecipeStore.cartItems', context: context);

  @override
  ObservableList<CartItem> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(ObservableList<CartItem> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$storeRecipesToIsarAsyncAction =
      AsyncAction('_RecipeStore.storeRecipesToIsar', context: context);

  @override
  Future<void> storeRecipesToIsar() {
    return _$storeRecipesToIsarAsyncAction
        .run(() => super.storeRecipesToIsar());
  }

  late final _$addToCartAsyncAction =
      AsyncAction('_RecipeStore.addToCart', context: context);

  @override
  Future<void> addToCart(CartItem cartItem) {
    return _$addToCartAsyncAction.run(() => super.addToCart(cartItem));
  }

  late final _$removeFromCartAsyncAction =
      AsyncAction('_RecipeStore.removeFromCart', context: context);

  @override
  Future<void> removeFromCart(int id) {
    return _$removeFromCartAsyncAction.run(() => super.removeFromCart(id));
  }

  late final _$updateCartItemsAsyncAction =
      AsyncAction('_RecipeStore.updateCartItems', context: context);

  @override
  Future<void> updateCartItems() {
    return _$updateCartItemsAsyncAction.run(() => super.updateCartItems());
  }

  @override
  String toString() {
    return '''
recipes: ${recipes},
cartItems: ${cartItems}
    ''';
  }
}
