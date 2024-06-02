import 'package:isar/isar.dart';

import './food_item.dart';

part 'recipe_isar.g.dart';

@Collection()
class RecipeIsar {
  Id isarid = Isar.autoIncrement;

  late int id;
  late String title;
  late String image;

  Recipe toRecipe() {
    return Recipe(
      id: id,
      title: title,
      image: image,
    );
  }

  static RecipeIsar fromRecipe(Recipe recipe) {
    return RecipeIsar()
      ..id = recipe.id
      ..title = recipe.title
      ..image = recipe.image;
  }
}
