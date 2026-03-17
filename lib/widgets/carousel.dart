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
  final CarouselController controller = CarouselController();
  late Future<List<Item>> _carouselItems;

  @override
  void initState() {
    super.initState();
    _carouselItems = ItemService.getCarouselItems();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height / 2.5),
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
              return CarouselView.weighted(
                controller: controller,
                itemSnapping: true,
                flexWeights: const <int>[1, 7, 1],
                children: items.map((Item item) {
                  return HeroLayoutCard(itemInfo: item);
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
