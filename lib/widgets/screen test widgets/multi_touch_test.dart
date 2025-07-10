import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiTouchTestScreen extends StatefulWidget {
  const MultiTouchTestScreen({super.key});

  @override
  State<MultiTouchTestScreen> createState() => _MultiTouchTestScreenState();
}

class _MultiTouchTestScreenState extends State<MultiTouchTestScreen> {
  final Map<int, Offset> touches = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerDown: (event) {
          setState(() {
            touches[event.pointer] = event.localPosition;
          });
        },
        onPointerMove: (event) {
          setState(() {
            touches[event.pointer] = event.localPosition;
          });
        },
        onPointerUp: (event) {
          setState(() {
            touches.remove(event.pointer);
          });
        },
        child: CustomPaint(
          painter: MultiTouchPainter(touches),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}

class MultiTouchPainter extends CustomPainter {
  final Map<int, Offset> touches;

  MultiTouchPainter(this.touches);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.red;

    touches.forEach((key, position) {
      canvas.drawCircle(position, 30, paint);
    });
  }

  @override
  bool shouldRepaint(MultiTouchPainter oldDelegate) => true;
}
