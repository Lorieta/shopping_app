import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopping_app/views/landing.dart';
import 'package:shopping_app/views/login.dart';
import 'package:shopping_app/views/signup.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/views/home.dart';
import 'package:shopping_app/widgets/navbar.dart';
import 'package:shopping_app/views/deals.dart';
import 'package:shopping_app/views/profile.dart';
import 'package:shopping_app/views/shopping_cart.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/views/content.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cartprovider.dart';
import 'services/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final loggedIn = await authService.getUserData(1) != null;
  late final DatabaseHelper db = DatabaseHelper();
  await db.initDb(); // Ensure the database is initialized
  // Ensure the database connection is established
  runApp(MyApp(isLoggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});

  late final GoRouter _router = GoRouter(
    initialLocation: isLoggedIn ? '/home' : '/',
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
          GoRoute(path: '/home', builder: (_, __) => const Home()),
          GoRoute(path: '/deals', builder: (_, __) => const Deals()),
          /*      GoRoute(path: '/profile', builder: (_, __) => const Profile()),*/
          GoRoute(path: '/cart', builder: (_, __) => const ShoppingCart()),
        ],
      ),
    ],
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp.router(
        title: 'Embedix',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D585F)),
        ),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        routerConfig: _router,
      ),
    );
  }
}
