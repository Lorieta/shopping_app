import 'package:go_router/go_router.dart';
import 'package:shopping_app/views/cart.dart';
import 'package:shopping_app/views/content.dart';
import 'package:shopping_app/views/deals.dart';
import 'package:shopping_app/views/home.dart';
import 'package:shopping_app/views/landing.dart';
import 'package:shopping_app/views/login.dart';
import 'package:shopping_app/views/profile.dart';
import 'package:shopping_app/views/signup.dart';
import 'package:shopping_app/widgets/navbar.dart';

class Routes {
  final String initialLocation;
  Routes({this.initialLocation = '/'});
  late final GoRouter _router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      // Auth pages — no bottom nav
      GoRoute(
        path: '/content',
        builder: (context, state) {
          final item = state.extra as dynamic;
          return Content(item: item);
        },
      ),
      GoRoute(path: '/', builder: (context, state) => const Landing()),
      GoRoute(path: '/login', builder: (context, state) => const Login()),
      GoRoute(path: '/signup', builder: (context, state) => const Signup()),

      // Shell — bottom nav wraps these routes
      ShellRoute(
        builder: (context, state, child) => Navbar(child: child),
        routes: [
          GoRoute(path: '/home', builder: (_, _) => const Home()),
          GoRoute(path: '/deals', builder: (_, _) => const Deals()),
          GoRoute(path: '/profile', builder: (_, _) => const Profile()),
          GoRoute(path: '/cart', builder: (_, _) => const ShoppingCart()),
        ],
      ),
    ],
  );
  GoRouter get router => _router;
}
