

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:win_utility/about_widget.dart';
import 'package:win_utility/old_main.dart';

class NavigationViewHome extends StatefulWidget {
  const NavigationViewHome({super.key});

  @override
  State<NavigationViewHome> createState() => _NavigationViewHomeState();
}

class _NavigationViewHomeState extends State<NavigationViewHome> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      
      appBar: NavigationAppBar(
        height: 40,
        automaticallyImplyLeading: false,
        title: Text('NukeCache'),
        actions: WindowButtons(),
      ),
        pane: NavigationPane(
          displayMode: PaneDisplayMode.compact,
          size: NavigationPaneSize(
            openMinWidth: 50,
            openMaxWidth: 100
            ,compactWidth: 40
          ),
          items: 
          [
            PaneItem(icon: Icon(Icons.home), title: Text('Home'), body:   HomeScreenPage()),
              // PaneItem(icon: Icon(Icons.settings), body: Container(color: material.Colors.red,),title: Text('Settings'),),
              PaneItem(icon: Icon(Icons.info), body: AboutWidget(),)
          ],
          selected: currentIndex,
          onChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      );
  }
}