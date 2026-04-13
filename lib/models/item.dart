class Item {
  const Item({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.description,
    required this.category,
  });

  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String description;
  final String category;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'description': description,
      'category': category,
    };
  }

  factory Item.fromJson(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as double,
      thumbnail: map['thumbnail'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
    );
  }
}
