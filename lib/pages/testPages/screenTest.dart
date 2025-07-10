import 'package:flutter/material.dart';

import '../../widgets/screen test widgets/dead_pixel_screen_test.dart';
import '../../widgets/screen test widgets/gradient_brightness_test.dart';
import '../../widgets/screen test widgets/multi_touch_test.dart';
import '../../widgets/screen test widgets/touch_grid_test.dart';
import '../../widgets/screen test widgets/touch_trace_test.dart';

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
