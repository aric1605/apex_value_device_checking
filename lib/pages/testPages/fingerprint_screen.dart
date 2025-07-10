import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class FingerprintCheckScreen extends StatefulWidget {
  const FingerprintCheckScreen({super.key});

  @override
  State<FingerprintCheckScreen> createState() => _FingerprintCheckScreenState();
}

class _FingerprintCheckScreenState extends State<FingerprintCheckScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  bool _canCheckBiometrics = false;
  bool _hasSecureBiometrics = false;
  bool _isDeviceSupported = false;
  String _authStatus = 'Not checked yet';

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      final bool canCheck = await auth.canCheckBiometrics;
      final bool isSupported = await auth.isDeviceSupported();
      final List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();

      print('Available biometrics: $availableBiometrics');

      final bool hasSecureBiometrics =
          availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.fingerprint);

      setState(() {
        _canCheckBiometrics = canCheck;
        _isDeviceSupported = isSupported;
        _hasSecureBiometrics = hasSecureBiometrics;
      });
    } on PlatformException catch (e) {
      setState(() {
        _authStatus = 'Error checking biometrics: ${e.message}';
      });
    }
  }

  Future<void> _authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate with your fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _authStatus = didAuthenticate
            ? 'Authentication successful!'
            : 'Authentication failed or cancelled.';
      });
    } on PlatformException catch (e) {
      setState(() {
        _authStatus = 'Auth Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fingerprint Checker')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Device Supported: $_isDeviceSupported'),
            Text('Can Check Biometrics: $_canCheckBiometrics'),
            Text('Has Secure Biometrics: $_hasSecureBiometrics'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hasSecureBiometrics ? _authenticate : null,
              child: const Text('Test Fingerprint'),
            ),
            const SizedBox(height: 20),
            Text('Auth Status: $_authStatus'),
          ],
        ),
      ),
    );
  }
}
