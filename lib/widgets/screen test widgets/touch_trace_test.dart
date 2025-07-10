import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TraceTestScreen extends StatefulWidget {
  const TraceTestScreen({super.key});

  @override
  State<TraceTestScreen> createState() => _TraceTestScreenState();
}

class _TraceTestScreenState extends State<TraceTestScreen> {
  List<Offset> points = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            points.add(details.localPosition);
          });
        },
        onPanEnd: (_) {
          points.add(Offset.zero);
        },
        child: CustomPaint(
          painter: TracePainter(points),
          child: SizedBox.expand(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            points.clear();
          });
        },
      ),
    );
  }
}

class TracePainter extends CustomPainter {
  final List<Offset> points;
  TracePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(TracePainter oldDelegate) => true;
}
