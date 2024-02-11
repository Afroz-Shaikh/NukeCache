import 'package:flutter/material.dart';

class UnderDevelopmentWarningWidget extends StatelessWidget {
  const UnderDevelopmentWarningWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          1),
      tileColor: Colors.black,
      leading: const Icon(
        Icons.warning_rounded,
        color: Colors.amber,
        size: 40,
      ),
      subtitle: const Text('Create a restore point before playing around',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
      title: const Text('Still Under Development',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
