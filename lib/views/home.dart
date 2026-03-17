import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/header.dart';
import 'package:shopping_app/widgets/carousel.dart';
import 'package:shopping_app/widgets/item_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Header(),
          ),
        ),
        SliverToBoxAdapter(
          child: Carousel(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'All Items',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ItemGrid(),
      ],
    );
  }
}
