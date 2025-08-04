import 'package:apex_value_device_checking/pages/testPages/fingerprint_screen.dart';
import 'package:apex_value_device_checking/pages/testPages/gsm_check_page.dart';
import 'package:apex_value_device_checking/pages/testPages/screenTest.dart';
import 'package:apex_value_device_checking/pages/testPages/torch.dart';
import 'package:flutter/material.dart';
import 'package:apex_value_device_checking/pages/testPages/bettery_page.dart';
import 'package:apex_value_device_checking/pages/testPages/bluetooth_page.dart';
import 'package:apex_value_device_checking/pages/testPages/vibrate_page.dart';

import '../constants/device_card_utils.dart';
import '../widgets/device_card.dart';
import '../widgets/phone_info.dart';
import '../widgets/start_test_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final gridHeight = screenHeight * 0.65;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const PhoneInfo(),
              SizedBox(
                height: gridHeight,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(deviceCardUtilsList.length, (index) {
                    final device = deviceCardUtilsList[index];

                    return DeviceCard(
                      deviceCard: device,
                      onTap: () {
                        print("Tapped: ${device.title}");

                        if (device.title == "Battery") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BatteryPage(),
                            ),
                          );
                        } else if (device.title == "Vibrations") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const VibratePage(),
                            ),
                          );
                        } else if (device.title == "Bluetooth") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BluetoothPage(),
                              settings: const RouteSettings(
                                name: '/DeviceScreen',
                              ),
                            ),
                          );
                        } else if (device.title == "Screen") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Screentest(),
                              settings: const RouteSettings(
                                name: '/DeviceScreen',
                              ),
                            ),
                          );
                        } else if (device.title == "Fingerprint") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FingerprintCheckScreen(),
                              settings: const RouteSettings(
                                name: '/DeviceScreen',
                              ),
                            ),
                          );
                        } else if (device.title == "Gsm Network") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GSMCheckScreen(),
                              settings: const RouteSettings(
                                name: '/DeviceScreen',
                              ),
                            ),
                          );
                        } else if (device.title == "Torch") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TorchPage(),
                              settings: const RouteSettings(
                                name: '/DeviceScreen',
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }),
                ),
              ),
              const Spacer(),
              const StartTestButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
