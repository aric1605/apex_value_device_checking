import 'package:flutter/material.dart';

class StartTestButton extends StatelessWidget {
  const StartTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo[800],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: const Text(
          'Start Test',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
