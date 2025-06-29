import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  final Battery _battery = Battery();

  int _batteryLevel = -1;
  BatteryState? _batteryState;
  bool _isPowerSaver = false;

  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _initBatteryInfo();
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen(
      _updateBatteryState,
    );
  }

  Future<void> _initBatteryInfo() async {
    final level = await _battery.batteryLevel;
    final state = await _battery.batteryState;
    final powerSaver = await _battery.isInBatterySaveMode;

    setState(() {
      _batteryLevel = level;
      _batteryState = state;
      _isPowerSaver = powerSaver;
    });
  }

  void _updateBatteryState(BatteryState state) async {
    if (_batteryState == state) return;
    final level = await _battery.batteryLevel;
    final powerSaver = await _battery.isInBatterySaveMode;

    setState(() {
      _batteryState = state;
      _batteryLevel = level;
      _isPowerSaver = powerSaver;
    });
  }

  @override
  void dispose() {
    _batteryStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isCharging = _batteryState == BatteryState.charging;
    bool allConditionsMet = isCharging && _isPowerSaver;

    String statusMessage;
    if (!isCharging) {
      statusMessage =
          "Please connect the charger And Turn On Power Saver Mode.";
    } else if (!_isPowerSaver) {
      statusMessage = "Please turn on Power Saver mode.";
    } else {
      statusMessage = "All set! You can end the test.";
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Battery Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Battery Level: $_batteryLevel%',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Charging Status: ${_batteryState?.name ?? "--"}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Power Saver Mode: ${_isPowerSaver ? "On" : "Off"}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Text(
                statusMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: allConditionsMet ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: allConditionsMet
                    ? () => Navigator.pop(context)
                    : null,
                child: const Text("End Test"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
