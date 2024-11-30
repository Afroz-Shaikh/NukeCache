import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About NukeCache', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text('NukeCache is a simple utility app that helps you clear your cache and free up space on your computer.'),
        SizedBox(height: 10,),
         Expander(
  header: Text('The main Goal ?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
  content: SizedBox(
    height: 100,
    child: SingleChildScrollView(
      child: Text('The Goal of this app was really to create something for myself and for my parents who aren\'t very tech savvy to have basic commnads at their disposal'),
    ),
  ),
),
          Text('Version: 0.0.3 -Pre Alpha'),
          Text('Developed by: Shaikh Afroz'),
        ],
      ),
    );
  }
}