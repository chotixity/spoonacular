import 'package:isar/isar.dart';

import 'recipe_item.dart';

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
      ..image = recipe.image ??
          "https://images.pexels.com/photos/3872366/pexels-photo-3872366.jpeg?auto=compress&cs=tinysrgb&w=400&lazy=load";
  }
}
