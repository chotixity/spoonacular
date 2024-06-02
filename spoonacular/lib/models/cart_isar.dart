import 'package:isar/isar.dart';

import './cart_item.dart';

part 'cart_isar.g.dart';

@Collection()
class CartItemIsar {
  Id? isarId;
  late int id;
  late String name;
  late String image;
  late int count;

  CartItem toCartItem() {
    return CartItem(
      id: id,
      name: name,
      image: image,
      count: count,
    );
  }

  static CartItemIsar fromCartItem(CartItem cartItem) {
    return CartItemIsar()
      ..id = cartItem.id
      ..name = cartItem.name
      ..image = cartItem.image
      ..count = cartItem.count;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItemIsar && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
