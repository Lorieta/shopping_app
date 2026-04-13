import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService {
  static bool _dismissedThisSession = false;

  static Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.appName} ${packageInfo.version} (${packageInfo.buildNumber})';
  }

  static Future<void> updateVersion(BuildContext context) async {
    if (_dismissedThisSession) return;

    final packageInfo = await PackageInfo.fromPlatform();
    final localVersion = packageInfo.version;
    final localBuild = packageInfo.buildNumber;

    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode != 200) return;

    // final data = jsonDecode(response.body);
    // final remoteVersion = data['data_version'] as String;
    // final remoteBuild = data['build_number'] as String;
    // final mandatory = data['mandatory'] as bool;

    var remoteVersion = '1.0.0+2';

    var mandatory = false;
    if (!context.mounted) return;

    if (remoteVersion != localVersion && mandatory == true) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Update Required'),
            // Message which will be pop up on the screen
            content: Text(
              'There is a new version of the app available. \nVersion: $remoteVersion \nBuild:$localBuild ',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text('Update'),
              ),
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text('Exit'),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Update Available'),
            // Message which will be pop up on the screen
            content: Text(
              'There is a new version of the app available. \nVersion: $remoteVersion \nBuild:$localBuild ',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _dismissedThisSession = true;
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Dismiss'),
              ),
            ],
          );
        },
      );
    }
  }
}
