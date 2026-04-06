import 'package:flutter/material.dart';
import '../models/item.dart.bak';
import '../services/item.dart.bak';
import 'card.dart';

class ItemGrid extends StatefulWidget {
  const ItemGrid({super.key});

  @override
  State<ItemGrid> createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
  late Future<List<Item>> _allItems;

  @override
  void initState() {
    super.initState();
    _allItems = ItemService.loadItems().then((items) => items ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: _allItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items found'));
        }

        final items = snapshot.data!.where((item) => !item.onCarousel).toList();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              mainAxisExtent: 220, // Increased to fit price if needed
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return HeroLayoutCard(itemInfo: items[index]);
            },
          ),
        );
      },
    );
  }
}
