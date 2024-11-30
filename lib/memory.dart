import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:system_info3/system_info3.dart';

double getMemoryUsage() {
  final totalMemory = SysInfo.getTotalPhysicalMemory();
  final availableMemory = SysInfo.getFreePhysicalMemory();
  final usedMemory = totalMemory - availableMemory;
  return usedMemory / totalMemory;
}

class MemoryUsageIndicator extends StatefulWidget {
  @override
  _MemoryUsageIndicatorState createState() => _MemoryUsageIndicatorState();
}

class _MemoryUsageIndicatorState extends State<MemoryUsageIndicator> {
  double memoryUsage = 0.0;

  @override
  void initState() {
    super.initState();
    _updateMemoryUsage();
  }

  void _updateMemoryUsage() {
   if(mounted){
     setState(() {
      memoryUsage = getMemoryUsage();
    });
   }
    Future.delayed(Duration(seconds: 1), _updateMemoryUsage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
       
        
         Row(
                  children: [
                    Gap(10),
                    Text(
                      'Current Memory Usage',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text('${(memoryUsage * 100).toStringAsFixed(2)}%',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                    Gap(10)
                  ],
                ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ProgressBar(value: memoryUsage * 100,strokeWidth: 10,)),
        SizedBox(height: 20),
      
      ],
    );
  }
}
