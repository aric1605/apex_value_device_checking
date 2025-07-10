import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeadPixelTestScreen extends StatefulWidget {
  const DeadPixelTestScreen({super.key});

  @override
  State<DeadPixelTestScreen> createState() => _DeadPixelTestScreenState();
}

class _DeadPixelTestScreenState extends State<DeadPixelTestScreen> {
  final List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.cyan,
    Colors.deepPurple,
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void nextColor() {
    setState(() {
      if (currentIndex < colors.length - 1) {
        currentIndex++;
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextColor,
      child: SizedBox.expand(child: Container(color: colors[currentIndex])),
    );
  }
}
