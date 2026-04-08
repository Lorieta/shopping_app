import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/classes/logger.dart';
import 'package:shopping_app/providers/themeprovider.dart';
import 'package:shopping_app/providers/userprovider.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _pickImage() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (returnedImage == null) {
      AppLogger.logger.w('User closed the picker without selecting an image.');
      return;
    }

    AppLogger.logger.d('Image picked: ${returnedImage.path}');

    AppLogger.logger.d('Updating provider...');
    await Provider.of<UserProvider>(
      context,
      listen: false,
    ).updateProfilePic(returnedImage.path);
    AppLogger.logger.d('Provider update complete.');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userProvider = Provider.of<UserProvider>(context);
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);

    final imageFileRaw =
        (userProvider.user?['profile_image_url'] ??
                userProvider.user?['profileImageUrl'])
            ?.toString();
    final String? imageFile =
        (imageFileRaw == null || imageFileRaw.trim().isEmpty)
        ? null
        : imageFileRaw;
    String? firstName = userProvider.user?['firstName']?.toString();

    String? lastName = userProvider.user?['lastName']?.toString();
    String? username = userProvider.user?['username']?.toString();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: colorScheme.onPrimary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.logout),

                          onPressed: () {
                            context.go('/login');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Profile Icon
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      backgroundImage: (imageFile != null)
                          ? FileImage(File(imageFile))
                          : null,
                      child: (imageFile == null)
                          ? Icon(
                              Icons.person,
                              size: 48,
                              color: colorScheme.onSurface.withOpacity(0.4),
                            )
                          : null,
                    ),
                  ),

                  Text(
                    '$firstName $lastName',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('@$username'),
                  const SizedBox(width: 12),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 250,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [Icon(Icons.account_circle), Text('Profile')],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [Icon(Icons.settings), Text('Settings')],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            _themeProvider.currentTheme == ThemeEnum.Dark
                                ? Icons.dark_mode
                                : Icons.light_mode,
                          ),

                          Text('Theme Switch'),
                          Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Switch(
                              value:
                                  _themeProvider.currentTheme == ThemeEnum.Dark,
                              onChanged: (isDark) {
                                _themeProvider.changeTheme(
                                  isDark ? ThemeEnum.Dark : ThemeEnum.Light,
                                );
                              },
                              activeThumbColor: colorScheme.primary,
                              inactiveThumbColor: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
