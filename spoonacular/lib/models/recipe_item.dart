import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_item.freezed.dart';
part 'recipe_item.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required int id,
    required String title,
    String? image,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
