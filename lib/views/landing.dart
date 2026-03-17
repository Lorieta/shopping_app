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
                context.go('/home');
              },
              child: const Text('Go to Home'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Requesting Camera Permission');
                requestPermission(Permission.camera);
              },
              child: const Text('Request Camera Permission'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> requestPermission(Permission permission) async {
    // 1. Check the current status
    var status = await permission.status;

    if (status.isGranted) {
      print("Permission already granted!");
      // Proceed with opening Camera/Gallery
    } else if (status.isDenied) {
      // 2. Request the permission
      if (await permission.request().isGranted) {
        print("Permission granted after request.");
      }
    } else if (status.isPermanentlyDenied) {
      // 3. Show a dialog to open App Settings
      openAppSettings();
    }
  }
}
