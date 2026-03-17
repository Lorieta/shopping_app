import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item.dart';
import 'card.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late Future<List<Item>> _carouselItems;

  @override
  void initState() {
    super.initState();
    _carouselItems = ItemService.getCarouselItems();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FutureBuilder<List<Item>>(
        future: _carouselItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items found'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: HeroLayoutCard(itemInfo: items[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
