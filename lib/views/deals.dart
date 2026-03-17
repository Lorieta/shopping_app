import 'package:flutter/material.dart';

class Deals extends StatelessWidget {
  const Deals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deals')),
      body: const Center(child: Text('Welcome to the Deals Page!')),
    );
  }
}
