import 'package:flutter/material.dart';
import '../services/version_service.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  late final Future<String> _versionFuture;

  @override
  void initState() {
    super.initState();
    _versionFuture = VersionService.getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [Text('Profile Settings')]),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [Text('Profile Settings')]),
              ),
            ),
            FutureBuilder<String>(
              future: _versionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error loading version: ${snapshot.error}');
                }
                return Text(snapshot.data ?? 'Version information unavailable');
              },
            ),
          ],
        ),
      ),
    );
  }
}
