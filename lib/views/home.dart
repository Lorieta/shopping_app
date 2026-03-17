import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Header()],
        ),
      ),
    );
  }
}
