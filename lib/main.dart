import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopping_app/providers/themeprovider.dart';
import 'package:shopping_app/providers/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cartprovider.dart';
import './classes/database.dart';
import 'classes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeProvider.instance.changeTheme(ThemeEnum.Light);
  await DatabaseHelper.instance.database;

  final userProvider = UserProvider();

  final routes = Routes(
    initialLocation: userProvider.isLoggedIn ? '/home' : '/',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userProvider),
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider.instance),
      ],

      child: MyApp(router: routes.router),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Embedix',
      theme: Provider.of<ThemeProvider>(context).currentThemeData,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      routerConfig: router,
    );
  }
}
