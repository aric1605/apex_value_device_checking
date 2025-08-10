import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../constants/nfcHardwareCheckPlatformChannel.dart';

class NfcCheckPage extends StatefulWidget {
  const NfcCheckPage({super.key});

  @override
  State<NfcCheckPage> createState() => _NfcCheckPageState();
}

class _NfcCheckPageState extends State<NfcCheckPage> {
  String _nfcStatus = 'Checking...';

  @override
  void initState() {
    super.initState();
    _checkNfcSupport();
  }

  Future<void> _checkNfcSupport() async {
    bool isAvailable = await NfcManager.instance.isAvailable();

    setState(() {
      _nfcStatus = isAvailable
          ? 'NFC is available and enabled!'
          : 'NFC is NOT available or disabled.';
    });
  }

  // Future<void> _checkNfcSupport() async {
  //   final hasHardware = await NfcHardwareCheck.hasNfcHardware();
  //   final isEnabled = await NfcManager.instance.isAvailable();
  //
  //   setState(() {
  //     if (!hasHardware) {
  //       _nfcStatus = 'NFC hardware not present on this device.';
  //     } else if (!isEnabled) {
  //       _nfcStatus = '⚠NFC hardware is present but currently disabled.';
  //     } else {
  //       _nfcStatus = 'NFC is available and enabled!';
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NFC Check')),
      body: Center(
        child: Text(_nfcStatus, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
