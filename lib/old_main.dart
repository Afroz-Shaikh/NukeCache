
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart' as FL;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:nukeCache/main.dart';
import 'package:nukeCache/memory.dart';
import 'package:nukeCache/service/win_service.dart';


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
        
          Container(
              
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
              ))
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
                // const UnderDevelopmentWarningWidget(),
                FL.InfoBar(title: Text('App is still under development'),
                isIconVisible: true,
                content: Text('This app is still under development. Some features may not work as expected. Please create a restore point before using this app.'),
                onClose: () {
                  
                },
                ),
                const Gap(10),
               
              
                MemoryUsageIndicator(),
                // LinearGauge(
                //   enableGaugeAnimation: true,

                //   animationGap: 0.9,
                //   linearGaugeBoxDecoration: LinearGaugeBoxDecoration(
                //       thickness: 20.0,
                //       borderRadius: 30,
                //       linearGaugeValueColor: Colors.green,
                //       edgeStyle: LinearEdgeStyle.bothCurve,
                //       backgroundColor: Colors.grey.shade300),
                //   start: 0,
                //   // value: 70,
                //   end: 100,
                //   gaugeOrientation: GaugeOrientation.horizontal,
                //   valueBar: const [
                //     ValueBar(
                //         value: 70,
                //         color: Colors.green,
                //         valueBarThickness: 20,
                //         borderRadius: 30)
                //   ],

                //   rulers: RulerStyle(
                //     secondaryRulersWidth: 1,
                //     secondaryRulerPerInterval: 1,
                //     secondaryRulersHeight: 20,
                //     secondaryRulerColor: Colors.black,
                //     showPrimaryRulers: false,
                //     rulersOffset: 10,
                //     labelOffset: 10,
                //     showSecondaryRulers: true,
                //     inverseRulers: false,
                //     rulerPosition: RulerPosition.center,
                //     showLabel: false,
                //   ),
                // ),
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

class ListTileClearWidget extends FL.StatefulWidget {
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
  FL.State<ListTileClearWidget> createState() => _ListTileClearWidgetState();
}



class _ListTileClearWidgetState extends FL.State<ListTileClearWidget> {

  void showContentDialog(BuildContext context) async {
  final result = await showDialog<String>(
    context: context,
    builder: (context) => FL.ContentDialog(
      title: const Text('Run the Command ?',style: FL.TextStyle(
        fontSize: 13
      ),),
      content:  Text(
        'This will ${widget.subtitle} completely ',
      ),
      actions: [
        FL.Button(
          child: const Text('Delete'),
          onPressed: () {
            Navigator.pop(context, 'User deleted file');
            // Delete file here
            widget.onTap!();
          },
        ),
        FilledButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context, 'User canceled dialog'),
        ),
      ],
    ),
  );
  setState(() {});
}


  @override
  Widget build(BuildContext context) {
    return FL.ListTile(
      cursor: SystemMouseCursors.click,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
     
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      trailing: FL.FilledButton(child: Text('RUN'), onPressed: (){
        //
        showContentDialog(context);
        
      }),
     
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
  iconNormal: Colors.blueAccent,
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
    return Padding(
      padding:  EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MinimizeWindowButton(colors: buttonColors),
          // MaximizeWindowButton(colors: buttonColors),
          CloseWindowButton(colors: closeButtonColors),
        ],
      ),
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
