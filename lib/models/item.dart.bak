class Item {
  const Item({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.price,
    required this.description,
    this.onCarousel = false,
  });

  final String id;
  final String name;
  final String type;
  final String image;
  final double price;
  final String description;
  final bool onCarousel;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'image': image,
      'price': price,
      'description': description,
      'onCarousel': onCarousel,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['itemId']?.toString() ?? map['id']?.toString() ?? '',
      name: map['itemName']?.toString() ?? map['name']?.toString() ?? '',
      type: map['itemType']?.toString() ?? map['type']?.toString() ?? '',
      image: map['itemImage']?.toString() ?? map['image']?.toString() ?? '',
      price: (map['itemPrice'] ?? map['price'] ?? 0).toDouble(),
      description:
          map['itemDescription']?.toString() ??
          map['description']?.toString() ??
          '',
      onCarousel: (map['onCarousel'] ?? 0) == 1 || map['onCarousel'] == true,
    );
  }
}
