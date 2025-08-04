import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class TorchPage extends StatefulWidget {
  const TorchPage({super.key});

  @override
  State<TorchPage> createState() => _TorchPageState();
}

class _TorchPageState extends State<TorchPage> {
  bool torchState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            bool isTorchAvailable = await checkTorchPresence();
            if (isTorchAvailable) {
              if (!torchState) {
                await TorchLight.enableTorch();
              } else {
                await TorchLight.disableTorch();
              }
              setState(() {
                torchState = !torchState;
              });
            }
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.lightBlue,
            ),
            child: Center(
              child: Icon(
                torchState ? Icons.flashlight_on : Icons.flashlight_off,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> checkTorchPresence() async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      // Handle error
      return false;
    }
  }
}
