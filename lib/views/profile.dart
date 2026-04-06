import 'package:flutter/material.dart';

import 'package:shopping_app/providers/themeprovider.dart';
import 'package:shopping_app/providers/userprovider.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shopping_app/widgets/header.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final userProvider = Provider.of<UserProvider>(context);
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    String? imageFile = userProvider.user?['profilepic']?.toString();
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

                  Text(
                    '$firstName $lastName',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('@$username' ?? ''),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(children: [Text("Total Orders")]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(children: [Text("Total Orders")]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(children: [Text("Total Orders")]),
                  ),
                ),
              ],
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
