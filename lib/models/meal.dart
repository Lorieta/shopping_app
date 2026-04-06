import 'dart:convert';

class Meal {
  const Meal({required this.id, required this.title, required this.thumbnail});
  final int id;
  final String title;
  final String thumbnail;

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'thumbnail': thumbnail};
  }

  factory Meal.fromJson(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] as int,
      title: map['title'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }
}
