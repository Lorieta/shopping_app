class Item {
  const Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    required this.itemImage,
    required this.itemPrice,
    required this.itemDescription,
    this.onCarousel = false,
  });

  final String itemId;
  final String itemName;
  final String itemType;
  final String itemImage;
  final double itemPrice;
  final String itemDescription;
  final bool onCarousel;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      itemType: json['itemType'] as String,
      itemImage: json['itemImage'] as String,
      itemPrice: (json['itemPrice'] as num).toDouble(),
      itemDescription: json['itemDescription'] as String,
      onCarousel: json['onCarousel'] as bool? ?? false,
    );
  }
}
