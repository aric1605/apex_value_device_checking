import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';

class Proximitysensorpage extends StatefulWidget {
  const Proximitysensorpage({super.key});

  @override
  State<Proximitysensorpage> createState() => _ProximitysensorpageState();
}

class _ProximitysensorpageState extends State<Proximitysensorpage> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    await ProximitySensor.setProximityScreenOff(true).onError((
      error,
      stackTrace,
    ) {
      if (foundation.kDebugMode) {
        debugPrint("could not enable screen off functionality");
      }
      return null;
    });

    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        if (foundation.kDebugMode) {
          debugPrint("sensor event = $event");
        }
        _isNear = (event > 0) ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proximity Sensor Example')),
      body: Center(child: Text('proximity sensor, is near ?  $_isNear\n')),
    );
  }
}
