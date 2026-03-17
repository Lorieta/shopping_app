import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    // Automatically request camera permission on page load
    requestPermission(Permission.camera);
  }

  Future<void> requestPermission(Permission permission) async {
    var status = await permission.status;
    if (!status.isGranted && !status.isPermanentlyDenied) {
      await permission.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Landing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Shopping App!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Navigating to Home');
                context.go('/login');
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }

 
}
