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

  late final _$_RecipeStoreActionController =
      ActionController(name: '_RecipeStore', context: context);

  @override
  void addToCart(CartItem item) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.addToCart');
    try {
      return super.addToCart(item);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(int id) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.removeFromCart');
    try {
      return super.removeFromCart(id);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recipes: ${recipes},
cartItems: ${cartItems}
    ''';
  }
}
