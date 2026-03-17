import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item.dart';
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
    _allItems = ItemService.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: _allItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('No items found')),
          );
        }

        final items = snapshot.data!;
        return SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HeroLayoutCard(itemInfo: items[index]);
              },
              childCount: items.length,
            ),
          ),
        );
      },
    );
  }
}
