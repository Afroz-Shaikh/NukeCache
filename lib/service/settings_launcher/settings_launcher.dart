import 'package:flutter/services.dart';

class WindowsSettingsLauncher {
  static const MethodChannel _channel = MethodChannel(
    'windows_settings_launcher',
  );
  // MethodChannel('windows_settings_launcher');
  static Future<void> launchWindowsSettings(String setting) async {
    try {
      await _channel.invokeMethod('launchStartupAppsSettings', setting);
    } on PlatformException catch (e) {
      print("Failed to launch Windows settings: '${e.message}'.");
    }
  }
}
