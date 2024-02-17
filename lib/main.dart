import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:gap/gap.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:win_utility/screens/sys_info_dialog.dart';
import 'package:win_utility/service/win_service.dart';
import 'package:win_utility/widgets/under_dev.dart';

int index = 0;
void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);

    win.minSize = initialSize;
    win.size = initialSize;
    win.maxSize = const Size(800, 600);
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
          child: const Row(
            children: [LeftSide(), RightSide()],
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
                Expanded(
                    child: Container(
                  child: ListView(
                    children: [
                      Container(
                          color: Colors.blueAccent,
                          child: Column(
                            children: [
                              Icon(Icons.home_repair_service_rounded,
                                  color: Colors.white, size: 40),
                              Gap(10),
                              Text('Home',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          )),
                      Gap(25),
                      GestureDetector(
                        onTap: () {
                          showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.blueAccent, width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  backgroundColor: Colors.white,
                                  content: const Text(
                                      'Settings Page Under Development'),
                                );
                              });
                        },
                        child: Container(
                            color: Colors.blueAccent,
                            child: Column(
                              children: [
                                Icon(Icons.settings_rounded,
                                    color: Colors.white, size: 40),
                                Gap(10),
                                Text('Settings',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            )),
                      ),
                      Gap(25),
                      ConfigurationWidget()
                    ],
                  ),
                ))
              ],
            )));
  }
}

class ConfigurationWidget extends StatefulWidget {
  const ConfigurationWidget({
    super.key,
  });

  @override
  State<ConfigurationWidget> createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = 1;
        });
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             const SystemInfoDialogue()));
        // showDialog(
        //     context: context,
        //     builder: (ctx) {
        //       return SystemInfoDialogue();
        //     });
      },
      child: Container(
          color: Colors.blueAccent,
          child: const Column(
            children: [
              Icon(Icons.info_rounded, color: Colors.white, size: 40),
              Gap(10),
              Text('System Configurations',
                  style: TextStyle(color: Colors.white)),
              Gap(10),
            ],
          )),
    );
  }
}

const backgroundStartColor = Color(0xff1d1d1d);
const backgroundEndColor = Color(0xff1d1d1d);

class RightSide extends StatefulWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
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
            child: Container(
              color: Colors.blueAccent,
              child: Row(
                children: [
                  Expanded(
                      child: MoveWindow(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('NukeCache',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
                  const WindowButtons()
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.red,
                child: IndexedStack(
                  index: index,
                  children: const [
                    HomeScreenPage(),
                    Center(child: Text('Second')),
                    Center(
                      child: Text('Third'),
                    ),
                  ],
                )),
          )
        ]),
      ),
    );
  }
}

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const UnderDevelopmentWarningWidget(),
                const Gap(10),
                const Row(
                  children: [
                    Gap(10),
                    Text(
                      'Current Memory Usage',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text('56%'),
                    Gap(10)
                  ],
                ),
                Gap(10),
                LinearGauge(
                  enableGaugeAnimation: true,

                  animationGap: 0.9,
                  linearGaugeBoxDecoration: LinearGaugeBoxDecoration(
                      thickness: 20.0,
                      borderRadius: 30,
                      linearGaugeValueColor: Colors.green,
                      edgeStyle: LinearEdgeStyle.bothCurve,
                      backgroundColor: Colors.grey.shade300),
                  start: 0,
                  // value: 70,
                  end: 100,
                  gaugeOrientation: GaugeOrientation.horizontal,
                  valueBar: const [
                    ValueBar(
                        value: 70,
                        color: Colors.green,
                        valueBarThickness: 20,
                        borderRadius: 30)
                  ],

                  rulers: RulerStyle(
                    secondaryRulersWidth: 1,
                    secondaryRulerPerInterval: 1,
                    secondaryRulersHeight: 20,
                    secondaryRulerColor: Colors.black,
                    showPrimaryRulers: false,
                    rulersOffset: 10,
                    labelOffset: 10,
                    showSecondaryRulers: true,
                    inverseRulers: false,
                    rulerPosition: RulerPosition.center,
                    showLabel: false,
                  ),
                ),
                Gap(10),
                ListTileClearWidget(
                  title: 'Clear Temp',
                  subtitle: 'Clear Windows Temp Directory c/windows/temp',
                  onTap: () {
                    clearWindowsTempDirectory();
                  },
                ),
                Gap(10),
                ListTileClearWidget(
                  title: 'Clear User Temp',
                  subtitle:
                      'Clear Current User Temp Directory c/users/username/appdata/local/temp',
                  onTap: () {
                    clearCurrentUserTempDirectory();
                  },
                ),
                Gap(10),
                ListTileClearWidget(
                  title: 'Clear Recycle Bin',
                  subtitle: 'Clear Recycle Bin c/\$Recycle.Bin',
                  onTap: () {
                    clearRecycleBin();
                  },
                ),
                Gap(10),
                ListTileClearWidget(
                  title: 'Clear Prefetch',
                  subtitle: 'Clear Prefetch Directory c/windows/prefetch',
                  onTap: () {
                    clearPrefetchDirectoryWithAdminPrivileges();
                  },
                ),
                Gap(10),
                ListTileClearWidget(
                  title: 'Clear SoftwareDistribution\\Download',
                  subtitle:
                      'Clear SoftwareDistribution\\Download c/windows/SoftwareDistribution/Download',
                  onTap: () {
                    clearSoftwareDistributionDownloadWithAdminPrivileges();
                  },
                ),
                Gap(10),
                ListTileClearWidget(
                  title: 'Flush DNS Cache',
                  subtitle: 'Flush DNS Cache',
                  onTap: () {
                    flushDNSCache();
                  },
                ),
                Gap(10),
                ListTileClearWidget(
                  title: 'Run WSreset',
                  subtitle: 'Run WSreset',
                  onTap: () {
                    runWSReset();
                  },
                ),
                const Gap(10),
                ListTileClearWidget(
                  title: 'Get Memory Usage',
                  subtitle: 'Get Memory Usage',
                  onTap: () {
                    getMemoryUsage();
                  },
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListTileClearWidget extends StatelessWidget {
  const ListTileClearWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: Color(0xffF7F7F7),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          onPressed: () {
            onTap!();
          },
          child: Text("RUN")),
    );
  }
}

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

final buttonColors = WindowButtonColors(
  iconNormal: Colors.white,
  mouseOver: Color.fromARGB(255, 3, 33, 231),
  // mouseDown: const Color(0xFF805306),
  iconMouseOver: Colors.white,
  iconMouseDown: Color.fromARGB(255, 3, 33, 231),
);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: Colors.black,
    iconNormal: Colors.red,
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        // MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class MemoryUsageWidget extends StatefulWidget {
  @override
  _MemoryUsageWidgetState createState() => _MemoryUsageWidgetState();
}

class _MemoryUsageWidgetState extends State<MemoryUsageWidget> {
  double _memoryUsagePercentage = 0.0;

  @override
  void initState() {
    super.initState();
    updateMemoryUsagePercentage();
  }

  Future<void> updateMemoryUsagePercentage() async {
    try {
      final totalMemory = await getTotalMemory();
      final currentMemoryUsage = await getMemoryUsage();
      setState(() {
        _memoryUsagePercentage = (currentMemoryUsage / totalMemory) * 100;
      });
    } catch (e) {
      print('Error updating memory usage: $e');
    }
  }

  Future<int> getTotalMemory() async {
    // Implement the method to get total memory
    // For example, on Windows, you can use the getMemoryUsage function from the previous example
    // Replace the implementation according to your platform
    return 16 * 1024 * 1024 * 1024; // Example: 16 GB RAM
  }

  Future<int> getMemoryUsage() async {
    // Implement the method to get current memory usage
    // For example, you can use the method getMemoryUsage from the previous example
    // Replace the implementation according to your platform
    return 8 * 1024 * 1024 * 1024; // Example: 8 GB RAM used
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: _memoryUsagePercentage,
          min: 0,
          max: 100,
          divisions: 100,
          label: '$_memoryUsagePercentage%',
          onChanged: null, // Set onChanged to null to disable user interaction
        ),
        Text(
          'Memory Usage: ${_memoryUsagePercentage.toStringAsFixed(2)}%',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ],
    );
  }
}
