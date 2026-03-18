import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import '../models/item.dart';

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, required this.quantity});

  double get totalPrice => item.itemPrice * quantity;
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addItems(Item item, int quantity) {
    final existing = _items.firstWhereOrNull(
      (i) => i.item.itemId == item.itemId,
    );
    existing != null
        ? existing.quantity += quantity
        : _items.add(CartItem(item: item, quantity: quantity));
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.removeWhere((i) => i.item.itemId == item.itemId);
    notifyListeners();
  }

  void updateQuantity(Item item, int quantity) {
    if (quantity <= 0) return removeItem(item);

    final existing = _items.firstWhereOrNull(
      (i) => i.item.itemId == item.itemId,
    );
    if (existing != null) {
      existing.quantity = quantity;
      notifyListeners();
    }
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems => _items.length;
}
