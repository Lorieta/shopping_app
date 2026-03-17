// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key, required this.child});
  final Widget child;

  static const _tabs = [
    (path: '/home', icon: Icons.home_rounded, label: 'Home'),
    (path: '/deals', icon: Icons.local_offer_rounded, label: 'Deals'),

    (path: '/cart', icon: Icons.shopping_cart_rounded, label: 'Cart'),
    (path: '/profile', icon: Icons.person_rounded, label: 'Profile'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final idx = _tabs.indexWhere((t) => location.startsWith(t.path));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        destinations: _tabs
            .map(
              (t) => NavigationDestination(icon: Icon(t.icon), label: t.label),
            )
            .toList(),
      ),
    );
  }
}
