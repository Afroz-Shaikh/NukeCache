import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:win_utility/service/win_service.dart';

class SystemInfoDialogue extends StatefulWidget {
  const SystemInfoDialogue({super.key});

  @override
  State<SystemInfoDialogue> createState() => _SystemInfoDialogueState();
}

class _SystemInfoDialogueState extends State<SystemInfoDialogue> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late WindowsDeviceInfo _windowsDeviceInfo;

  _getDeviceInfo() async {
    WindowsDeviceInfo info = await deviceInfo.windowsInfo;
    setState(() {
      _windowsDeviceInfo = info;
    });
    print(info.computerName);
    print(info.numberOfCores);
    print(info.systemMemoryInMegabytes);
    print(info.platformId);
    print(info.userName);
    print(info.displayVersion);
    print(info.productName);
  }

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // _getDeviceInfo();
    // launchWinAbout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.black,
        child: Column(
          children: [
            Text(deviceInfo.toString()),
          ],
        ),
      ),
    );
  }
}
