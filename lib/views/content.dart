import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/cartprovider.dart';
import '../widgets/spanner.dart';

class Content extends StatefulWidget {
  const Content({super.key, required this.item});

  final Item item;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Image.network(
              widget.item.thumbnail,
              width: double.infinity,
              height: 320,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: double.infinity,
                height: 320,
                color: colorScheme.surface,
                child: Icon(
                  Icons.broken_image,
                  size: 64,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price
                  Text(
                    'Php.${widget.item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    widget.item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.item.description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: colorScheme.onSurface.withValues(alpha: 0.87),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text('Quantity', style: TextStyle(fontSize: 20)),
                      Spanner(
                        initialQuantity: _quantity,
                        onQuantityChanged: (newQuantity) {
                          setState(() {
                            _quantity = newQuantity;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description header
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        context.read<CartModel>().addItems(
                          widget.item,
                          _quantity,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added $_quantity to cart'),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: Text('Add to Cart'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
