import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

const borderColor = Colors.white;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child: Row(
            children: const [LeftSide(), RightSide()],
          ),
        ),
      ),
    );
  }
}

const sidebarColor = Colors.blueAccent;

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: Container(
            color: sidebarColor,
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                Expanded(child: Container())
              ],
            )));
  }
}

const backgroundStartColor = Color(0xff1d1d1d);
const backgroundEndColor = Color(0xff1d1d1d);

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: [0.0, 1.0]),
        ),
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          ),
          CurrentFunctionsWidget()
        ]),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: Colors.white,
  mouseOver: Color.fromARGB(255, 3, 33, 231),
  // mouseDown: const Color(0xFF805306),
  iconMouseOver: const Color(0xFF805306),
  iconMouseDown: Color.fromARGB(255, 3, 33, 231),
);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: Colors.red,
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class CurrentFunctionsWidget extends StatelessWidget {
  const CurrentFunctionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: ElevatedButton(
                onPressed: () {
                  // clearCurrentUserTempDirectory();
                  clearWindowsTempDirectory();
                },
                child: Text('Clear Temp'))),
        const Gap(20),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  clearCurrentUserTempDirectory();
                  // clearWindowsTempDirectory();
                  // Go to C:\Windows\Temp and delete all files
                },
                child: Text('Clear  User Temp'))),
        const Gap(20),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  clearRecycleBin();
                },
                child: Text('Clear Recycle Bin'))),
        const Gap(20),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  clearPrefetchDirectoryWithAdminPrivileges();
                },
                child: Text('Clear Prefetch'))),
        const Gap(20),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  clearSoftwareDistributionDownloadWithAdminPrivileges();
                },
                child: Text('Clear SoftwareDistribution\\Download'))),
        const Gap(20),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  flushDNSCache();
                },
                child: Text('Flush DNS Cache'))),
        const Gap(20),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  runWSReset();
                },
                child: Text('Run WSreset'))),
      ],
    );
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
