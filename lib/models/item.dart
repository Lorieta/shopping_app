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
      id: map['id'],
      name: map['name'],
      type: map['type'],
      image: map['image'],
      price: map['price'],
      description: map['description'],
      onCarousel: map['onCarousel'],
    );
  }
}
