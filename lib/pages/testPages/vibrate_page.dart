import 'package:flutter/material.dart';
import 'package:all_vibrate/all_vibrate.dart';

class VibratePage extends StatefulWidget {
  const VibratePage({super.key});

  @override
  State<VibratePage> createState() => _VibratePageState();
}

class _VibratePageState extends State<VibratePage> {
  final vibrate = AllVibrate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vibrate Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Simple vibrate'),
              onPressed: () {
                vibrate.simpleVibrate(period: 3000, amplitude: 200);
              },
            ),
          ],
        ),
      ),
    );
  }
}
