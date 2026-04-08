import 'package:flutter/material.dart';
import 'package:shopping_app/services/api_service.dart';
import '../models/categories.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _Category();
}

class _Category extends State<Category> {
  late Future<List<Categories>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = ApiService().getCategories().then(
      (category) => category ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items found'));
        }

        final categories = snapshot.data!;

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Row(children: [Text(categories[index].name)]);
          },
        );
      },
    );
  }
}
