import 'dart:io';

import 'package:nukeCache/service/settings_launcher/settings_launcher.dart';


Future<int> getMemoryUsage() async {
  try {
    final result = await Process.run('systeminfo', []);

    if (result.exitCode == 0) {
      final output = result.stdout as String;
      final lines = output.split('\n');
      for (final line in lines) {
        if (line.contains('Total Physical Memory:')) {
          final memoryInfo = line.split(':');
          final memoryString = memoryInfo[1].trim().split(' ')[0];
          return int.parse(memoryString.replaceAll(',', ''));
        }
      }
      return -1; // Memory information not found
    } else {
      print('Error getting memory usage: ${result.stderr}');
      return -1;
    }
  } catch (e) {
    print('Error getting memory usage: $e');
    return -1;
  }
}

Future<void> launchWinAbout() async {
  //ms-settings:about
  try {
    final result = WindowsSettingsLauncher.launchWindowsSettings(
        'launchStartupAppsSettings');

    print(result);
  } catch (e) {
    print('Error launching ms-settings:about: $e');
  }
}

void runWSReset() async {
  try {
    final result = await Process.run('WSreset.exe', [], runInShell: true);

    print(result.stdout);
  } catch (e) {
    print('Error running WSreset.exe: $e');
  }
}

void flushDNSCache() async {
  try {
    final result =
        await Process.run('ipconfig', ['/flushdns'], runInShell: true);

    print(result.stdout);
  } catch (e) {
    print('Error flushing DNS cache: $e');
  }
}

void clearSoftwareDistributionDownload() async {
  try {
    final result = await Process.run('cmd',
        ['/c', 'rd', '/s', '/q', 'C:\\Windows\\SoftwareDistribution\\Download'],
        runInShell: true);

    print(result.stdout);
  } catch (e) {
    print('Error clearing SoftwareDistribution\\Download directory: $e');
  }
}

void clearSoftwareDistributionDownloadWithAdminPrivileges() async {
  try {
    final result = await Process.run(
        'runas',
        [
          '/user:Administrator',
          'cmd',
          '/c',
          'rd',
          '/s',
          '/q',
          'C:\\Windows\\SoftwareDistribution\\Download'
        ],
        runInShell: true);

    print(result.stdout);
  } catch (e) {
    print('Error clearing SoftwareDistribution\\Download directory: $e');
  }
}

// void clearPrefetchDirectory() async {
//   try {
//     final result = await Process.run(
//         'cmd', ['/c', 'rd', '/s', '/q', 'C:\\Windows\\Prefetch']);

//     print(result.stdout);
//   } catch (e) {
//     print('Error clearing Prefetch directory: $e');
//   }
// }

void clearPrefetchDirectoryWithAdminPrivileges() async {
  try {
    final result = await Process.run(
        'runas',
        [
          '/user:Administrator',
          'cmd',
          '/c',
          'rd',
          '/s',
          '/q',
          'C:\\Windows\\Prefetch'
        ],
        runInShell: true);

    print(result.stdout);
  } catch (e) {
    print('Error clearing Prefetch directory: $e');
  }
}

void clearWindowsTempDirectory() async {
  try {
    final result =
        await Process.run('cmd', ['/c', 'rd', '/s', '/q', 'C:\\Windows\\Temp']);
    print('cleared windows temp directory');
    print(result.stdout);
  } catch (e) {
    print('Error clearing temp directory: $e');
  }
}

void clearCurrentUserTempDirectory() async {
  try {
    final username = Platform.environment['USERNAME'];
    print(username);
    final tempDirPath = 'C:\\Users\\$username\\AppData\\Local\\Temp';

    final result =
        await Process.run('cmd', ['/c', 'rd', '/s', '/q', tempDirPath]);
    print(result.stdout);
  } catch (e) {
    print('Error clearing temp directory: $e');
  }
}

void clearRecycleBin() async {
  try {
    final result = await Process.run('cmd', [
      '/c',
      'rd',
      '/s',
      '/q',
      '${Platform.environment['SystemDrive']}\\\$Recycle.Bin'
    ]);

    print(result.stdout);
  } catch (e) {
    print('Error clearing recycle bin: $e');
  }
}
