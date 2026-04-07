import 'dart:convert';

import './item.dart';

class OrderHistory {
  const OrderHistory({
    this.id,
    required this.item,
    required this.purchaseDate,
    required this.quantity,
  });
  final int? id;
  final Item item;
  final DateTime purchaseDate;
  final int quantity;

  Map<String, dynamic> toMap() {
    return {
      'item': jsonEncode(item.toJson()),
      'purchaseDate': purchaseDate.toIso8601String(),
      'quantity': quantity,
    };
  }

  factory OrderHistory.fromMap(Map<String, dynamic> map) {
    return OrderHistory(
      item: Item.fromJson(
        jsonDecode(map['item'] as String) as Map<String, dynamic>,
      ),
      purchaseDate: DateTime.parse(map['purchaseDate'] as String),
      quantity: map['quantity'] as int,
    );
  }
}
