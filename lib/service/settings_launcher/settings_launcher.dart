import 'package:flutter/services.dart';

class WindowsSettingsLauncher {
  static const MethodChannel _channel =
      MethodChannel('windows_settings_launcher');
  // MethodChannel('windows_settings_launcher');

  static Future<void> launchWindowsSettings() async {
    try {
      // Call the method using the method channel
      // await _channel.invokeMethod('launchWindowsSettings');
      await _channel.invokeMethod('launchWindowsSettings');
    } catch (e) {
      // Handle errors
      print('Error launching Windows settings: $e');
    }
  }
}
