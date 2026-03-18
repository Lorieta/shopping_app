import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../services/auth.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _imageFile;

  Widget _buildActionItem(BuildContext context, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  final ImagePicker _picker = ImagePicker();
  String _firstName = "";
  String _lastName = "";
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profile_image_path');
    final userData = await AuthService.getUserData();

    if (savedPath != null && File(savedPath).existsSync()) {
      setState(() {
        _imageFile = File(savedPath);
      });
    }

    setState(() {
      _firstName = userData['firstName'] ?? "";
      _lastName = userData['lastName'] ?? "";
      _username = userData['username'] ?? "";
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;

    // Check status FIRST — don't call .request() if permanently denied
    var status = await permission.status;

    if (status.isPermanentlyDenied) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('Please enable it in app settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
      return;
    }

    // Safe to call .request() here — will show the OS prompt if needed
    status = await permission.request();

    if (status.isGranted) {
      final picked = await _picker.pickImage(source: source);
      if (picked != null) {
        // Copy to app documents directory for persistence
        final appDir = await getApplicationDocumentsDirectory();

        // Use a unique timestamp to break Flutter's ImageCache which caches by file path
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'profile_$timestamp${p.extension(picked.path)}';
        final savedFile = await File(
          picked.path,
        ).copy('${appDir.path}/$fileName');

        // Delete the old file to save space
        if (_imageFile != null && _imageFile!.existsSync()) {
          try {
            _imageFile!.deleteSync();
          } catch (_) {}
        }

        // Save the path to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', savedFile.path);

        setState(() => _imageFile = savedFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                const SizedBox(height: 16),
                Text(
                  '$_firstName $_lastName',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(_username),
                const SizedBox(height: 24),
              ],
            ),

            // Order Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionItem(
                    context,
                    Icons.account_balance_wallet_outlined,
                    'To Pay',
                  ),
                  _buildActionItem(
                    context,
                    Icons.inventory_2_outlined,
                    'To Ship',
                  ),
                  _buildActionItem(
                    context,
                    Icons.local_shipping_outlined,
                    'To Receive',
                  ),
                  _buildActionItem(context, Icons.star_border, 'To Rate'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  onPressed: () {
                    context.go('/login');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
