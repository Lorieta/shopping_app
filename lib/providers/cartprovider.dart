import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:shopping_app/classes/logger.dart';
import '../models/item.dart';
import '../models/cart.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Getters
  List<CartItem> get items => _items;
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
  int get totalItems => _items.length;

  // Add item to cart
  void addItems(Item item, int quantity) {
    try {
      final existing = _items.firstWhereOrNull((i) => i.item.id == item.id);

      if (existing != null) {
        existing.quantity += quantity;
      } else {
        _items.add(CartItem(item: item, quantity: quantity));
      }

      notifyListeners();
    } on Exception catch (e) {
      AppLogger.logger.d(e);
    }
  }

  // Update quantity
  void updateQuantity(Item item, int quantity) {
    try {
      if (quantity <= 0) {
        removeItem(item);
        return;
      }

      final existing = _items.firstWhereOrNull((i) => i.item.id == item.id);
      if (existing != null) {
        existing.quantity = quantity;
        notifyListeners();
      }
    } on Exception catch (e) {
      AppLogger.logger.d(e);
    }
  }

  // Remove single item
  void removeItem(Item item) {
    try {
      _items.removeWhere((i) => i.item.id == item.id);
      notifyListeners();
    } on Exception catch (e) {
      AppLogger.logger.d(e);
    }
  }

  // Clear cart
  void removeAll() {
    try {
      _items.clear();
      notifyListeners();
    } on Exception catch (e) {
      AppLogger.logger.d(e);
    }
  }
}
