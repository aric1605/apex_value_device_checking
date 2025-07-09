import 'package:flutter/material.dart';

class DeviceCardUtils {
  final IconData icon;
  final String title;
  DeviceCardUtils({required this.icon, required this.title});
}

List<DeviceCardUtils> deviceCardUtilsList = [
  DeviceCardUtils(icon: Icons.wifi, title: "Wifi"),
  DeviceCardUtils(icon: Icons.battery_4_bar_sharp, title: "Battery"),
  DeviceCardUtils(icon: Icons.sd_storage_outlined, title: "Storage"),
  DeviceCardUtils(icon: Icons.sim_card, title: "Gsm Network"),
  DeviceCardUtils(icon: Icons.vibration, title: "Vibrations"),
  DeviceCardUtils(icon: Icons.fingerprint, title: "Fingerprint"),
  DeviceCardUtils(icon: Icons.bluetooth, title: "Bluetooth"),
  DeviceCardUtils(icon: Icons.gps_fixed, title: "Gps"),
  DeviceCardUtils(
    icon: Icons.center_focus_strong_outlined,
    title: "Auto Focus",
  ),
  DeviceCardUtils(icon: Icons.camera_alt_outlined, title: "Camera"),
  DeviceCardUtils(icon: Icons.nfc_outlined, title: "NFC"),
  DeviceCardUtils(icon: Icons.screen_rotation, title: "Auto Rotation"),
  DeviceCardUtils(icon: Icons.surround_sound, title: "Proximity"),
  DeviceCardUtils(icon: Icons.phone_android, title: "Screen"),
  DeviceCardUtils(icon: Icons.usb, title: "Micro USB"),
  DeviceCardUtils(icon: Icons.flashlight_on, title: "Torch"),
  DeviceCardUtils(icon: Icons.smart_button_outlined, title: "Device Buttons"),
  DeviceCardUtils(icon: Icons.speaker, title: "Top Speaker"),
  DeviceCardUtils(icon: Icons.speaker, title: "Bottom Speaker"),
  DeviceCardUtils(icon: Icons.speaker_phone_sharp, title: "Top Microphone"),
  DeviceCardUtils(icon: Icons.speaker_phone_sharp, title: "Bottom Microphone"),
];
