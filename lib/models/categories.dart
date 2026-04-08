// lib/models/category.dart

class Categories {
  final String slug;
  final String name;
  final String url;

  Categories({required this.slug, required this.name, required this.url});

  factory Categories.fromJson(Map<String, dynamic> map) {
    return Categories(
      slug: map['slug'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'slug': slug, 'name': name, 'url': url};
  }
}
