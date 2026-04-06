import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import '../models/item.dart.bak';

class CartItem {
  final Item item;
  int quantity;
  CartItem({required this.item, required this.quantity});
  double get totalPrice => item.price * quantity;
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Getters
  List<CartItem> get items => _items;
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
  int get totalItems => _items.length;

  // Add item to cart
  void addItems(Item item, int quantity) {
    final existing = _items.firstWhereOrNull((i) => i.item.id == item.id);

    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _items.add(CartItem(item: item, quantity: quantity));
    }

    notifyListeners();
  }

  // Update quantity
  void updateQuantity(Item item, int quantity) {
    if (quantity <= 0) {
      removeItem(item);
      return;
    }

    final existing = _items.firstWhereOrNull((i) => i.item.id == item.id);
    if (existing != null) {
      existing.quantity = quantity;
      notifyListeners();
    }
  }

  // Remove single item
  void removeItem(Item item) {
    _items.removeWhere((i) => i.item.id == item.id);
    notifyListeners();
  }

  // Clear cart
  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
