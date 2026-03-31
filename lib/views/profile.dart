import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shopping_app/providers/userprovider.dart';
import '../services/auth.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    String? imageFile = userProvider.user?['profilepic']?.toString();
    String? firstName = userProvider.user?['firstName']?.toString();
    String? lastName = userProvider.user?['lastName']?.toString();
    String? username = userProvider.user?['username']?.toString();

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
                // Profile Icon
                CircleAvatar(
                  radius: 48,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  backgroundImage: imageFile != null
                      ? FileImage(File(imageFile))
                      : null,
                  child: imageFile == null
                      ? Icon(
                          Icons.person,
                          size: 48,
                          color: colorScheme.onSurface.withOpacity(0.4),
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  '$firstName $lastName',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(username ?? ''),
                const SizedBox(height: 24),
              ],
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
