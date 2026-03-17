import 'package:flutter/material.dart';
import '../models/item.dart';

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, required this.quantity});
}

class CartState extends ChangeNotifier {
  // 1. Private constructor
  CartState._sharedInstance();

  // 2. Single static instance
  static final CartState instance = CartState._sharedInstance();

  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  void addItems(Item item, int quantity) {
    final existingIndex = _items.indexWhere((e) => e.item.itemId == item.itemId);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(item: item, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(Item item, int quantity) {
    final existingIndex = _items.indexWhere((e) => e.item.itemId == item.itemId);
    if (existingIndex >= 0) {
      if (quantity <= 0) {
        _items.removeAt(existingIndex);
      } else {
        _items[existingIndex].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void removeItem(Item item) {
    _items.removeWhere((e) => e.item.itemId == item.itemId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems {
    return _items.fold(0, (sum, current) => sum + current.quantity);
  }

  double get totalPrice {
    return _items.fold(0, (sum, current) => sum + (current.item.itemPrice * current.quantity));
  }
}
