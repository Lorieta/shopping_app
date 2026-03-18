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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 30.0), child: Header()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Hot items',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
          ),
          const Carousel(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'New arrivals',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
          ),
          const ItemGrid(),
        ],
      ),
    );
  }
}
