import 'package:flutter/material.dart';

import '../constants/device_card_utils.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.deviceCard, this.onTap});
  final DeviceCardUtils deviceCard;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(deviceCard.icon, size: 25, color: Colors.indigo),
            const SizedBox(height: 6),
            Text(
              deviceCard.title,
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
