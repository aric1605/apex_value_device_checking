import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

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
