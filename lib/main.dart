import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopping_app/providers/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cartprovider.dart';
import 'services/database.dart';
import 'services/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final routes = Routes();
  late final DatabaseHelper db = DatabaseHelper();

  await db.initDb(); // Ensure the database is initialized
  // Ensure the database connection is established
  final userProvider = UserProvider();

  await userProvider.restoreSession();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],

      child: MyApp(router: routes.router),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  MyApp({Key? key, required this.router}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp.router(
        title: 'Embedix',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 234, 255),
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 234, 255),
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
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
      ),
    );
  }
}
