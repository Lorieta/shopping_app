import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../providers/cartprovider.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key, required this.child});
  final Widget child;



  static const _tabs = [
    (path: '/home', icon: Icons.home_rounded, label: 'Home'),
    (path: '/deals', icon: Icons.favorite_border_rounded, label: 'Wishlist'),
    (path: '/cart', icon: Icons.shopping_bag_outlined, label: 'Cart'),
    (path: '/profile', icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final idx = _tabs.indexWhere((t) => location.startsWith(t.path));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final isSelected = i == current;
                final isCart = tab.path == '/cart';

                Widget iconWidget = Icon(
                  tab.icon,
                  color: isSelected ? Colors.white : Colors.black54,
                  size: 24,
                );

                if (isCart) {
                  iconWidget = ListenableBuilder(
                    listenable: CartState.instance,
                    builder: (context, child) {
                      final count = CartState.instance.totalItems;
                      if (count == 0) return child!;
                      return Badge.count(
                        count: count,
                        backgroundColor: Colors.redAccent,
                        child: child,
                      );
                    },
                    child: iconWidget,
                  );
                }

                return GestureDetector(
                  onTap: () => context.go(tab.path),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 48,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFB4D9CC)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(child: iconWidget),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected
                                ? const Color(0xFF0D585F)
                                : Colors.black54,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
