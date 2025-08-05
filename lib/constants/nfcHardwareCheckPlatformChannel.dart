import 'dart:io';
import 'package:flutter/services.dart';

class NfcHardwareCheck {
  static const _platform = MethodChannel('nfc_hardware_check');

  static Future<bool> hasNfcHardware() async {
    if (!Platform.isAndroid) return false;
    try {
      final bool result = await _platform.invokeMethod('hasNfcHardware');
      return result;
    } catch (e) {
      return false;
    }
  }
}

// import 'dart:io';
// import 'package:flutter/services.dart';
//
// class NfcHardwareCheck {
//   static const _platform = MethodChannel('nfc_hardware_check');
//
//   static Future<bool> hasNfcHardware() async {
//     if (!Platform.isAndroid) return false;
//     try {
//       final bool result = await _platform.invokeMethod('hasNfcHardware');
//       return result;
//     } catch (e) {
//       return false;
//     }
//   }
// }
