import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Screentest extends StatelessWidget {
  const Screentest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Dead Pixel Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DeadPixelTestScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Gradient & Brightness Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GradientTestScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Touch Trace Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TraceTestScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Touch Grid Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TouchGridTestScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Multi-Touch Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MultiTouchTestScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Dead Pixel test

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

//Gradient & Brightness Test

class GradientTestScreen extends StatelessWidget {
  const GradientTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      body: PageView(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Touch Trace Test

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

//Touch Grid Test

class TouchGridTestScreen extends StatefulWidget {
  const TouchGridTestScreen({super.key});

  @override
  State<TouchGridTestScreen> createState() => _TouchGridTestScreenState();
}

class _TouchGridTestScreenState extends State<TouchGridTestScreen> {
  static const int rows = 10;
  static const int cols = 6;

  final List<List<bool>> touched = List.generate(
    rows,
    (_) => List.generate(cols, (_) => false),
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final cellWidth = constraints.maxWidth / cols;
          final cellHeight = constraints.maxHeight / rows;

          return GestureDetector(
            onTapDown: (details) {
              final x = (details.localPosition.dx / cellWidth).floor();
              final y = (details.localPosition.dy / cellHeight).floor();

              if (x >= 0 && x < cols && y >= 0 && y < rows) {
                setState(() {
                  touched[y][x] = true;
                });
              }
            },
            child: CustomPaint(
              painter: GridPainter(touched),
              child: SizedBox.expand(),
            ),
          );
        },
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final List<List<bool>> touched;

  GridPainter(this.touched);

  @override
  void paint(Canvas canvas, Size size) {
    final int rows = touched.length;
    final int cols = touched[0].length;

    final double cellWidth = size.width / cols;
    final double cellHeight = size.height / rows;

    final Paint gridPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        final rect = Rect.fromLTWH(
          x * cellWidth,
          y * cellHeight,
          cellWidth,
          cellHeight,
        );

        if (touched[y][x]) {
          canvas.drawRect(rect, fillPaint);
        }

        canvas.drawRect(rect, gridPaint);
      }
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) => true;
}

//Multi-Touch Test

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
