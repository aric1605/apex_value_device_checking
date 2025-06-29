import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../utils/snackbar.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;

  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
      (results) {
        if (mounted) {
          setState(() => _scanResults = results);

          // ✅ Print each scanned device in console
          for (var result in results) {
            print(
              'Scanned device: ${result.device.name.isNotEmpty ? result.device.name : "Unknown Device"} (${result.device.id.id})',
            );
          }
        }
      },
      onError: (e) {
        Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
      },
    );

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      if (mounted) {
        setState(() => _isScanning = state);
      }
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e, backtrace) {
      Snackbar.show(
        ABC.b,
        prettyException("Start Scan Error:", e),
        success: false,
      );
      print(e);
      print("backtrace: $backtrace");
    }
  }

  Widget buildScanButton() {
    return ElevatedButton(
      onPressed: _isScanning ? null : onScanPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      child: _isScanning ? const Text("SCANNING...") : const Text("SCAN"),
    );
  }

  List<Widget> _buildScanResultTiles() {
    return _scanResults.map((r) {
      return ListTile(
        title: Text(
          r.device.name.isNotEmpty ? r.device.name : "Unknown Device",
        ),
        subtitle: Text(r.device.id.id),
        onTap: () {
          // Do nothing on tap
        },
      );
    }).toList();
  }

  Widget buildEndTestButton() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text("END TEST"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyB,
      child: Scaffold(
        appBar: AppBar(title: const Text('Bluetooth Test')),
        body: Stack(
          children: [
            Positioned(
              top: 50,
              left: 30,

              child: Text("Bluetooth Test Completed"),
            ),
            buildEndTestButton(),
          ],
        ),
      ),
    );
  }
}
