import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'dart:ui';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:gap/gap.dart';

import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:win_utility/navigation_pane.dart';
import 'package:win_utility/old_main.dart';
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

var borderColor = Colors.white;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   body: WindowBorder(
      //     color: borderColor,
      //     width: 1,
      //     child: const Row(
      //       children: [LeftSide(), RightSide()],
      //     ),
      //   ),
      // ),
      home: NavigationViewHome(),
    );
  }
}
