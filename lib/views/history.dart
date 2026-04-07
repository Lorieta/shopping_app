import 'package:flutter/material.dart';
import '../services/order_history_service.dart';
import '../models/order_history.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<List<OrderHistory>> _allHistory;

  @override
  void initState() {
    super.initState();
    _allHistory = OrderHistoryService().loadHistory().then(
      (history) => history ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderHistory>>(
      future: _allHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items found'));
        }

        final history = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final order = history[index];
            return ListTile(
              leading: Image.network(order.item.thumbnail),
              title: Text(order.item.title),
              subtitle: Text('\Php. ${order.item.price}'),
              trailing: Text('x${order.quantity}'),
            );
          },
        );
      },
    );
  }
}
