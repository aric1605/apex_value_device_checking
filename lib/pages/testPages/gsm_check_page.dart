import 'package:flutter/material.dart';
import 'package:another_telephony/telephony.dart';

class GSMCheckScreen extends StatefulWidget {
  const GSMCheckScreen({super.key});
  @override
  State<GSMCheckScreen> createState() => _GSMCheckScreenState();
}

class _GSMCheckScreenState extends State<GSMCheckScreen> {
  final Telephony telephony = Telephony.instance;

  String status = "Checking...";
  SimState? simState;
  PhoneType? phoneType;
  ServiceState? serviceState;
  String? networkOperatorName;
  List<SignalStrength> signalStrengths = [];

  @override
  void initState() {
    super.initState();
    final telephony = Telephony.instance;

    telephony.requestPhonePermissions.then((granted) {
      if (granted ?? false) {
        checkSimPresence(telephony);
      }
    });
  }

  Future<void> checkGSMStatus() async {
    bool permissionsGranted = await telephony.requestPhonePermissions ?? false;
    if (!permissionsGranted) {
      setState(() => status = "Permissions not granted.");
      return;
    }
    simState = await telephony.simState;
    phoneType = await telephony.phoneType;
    serviceState = await telephony.serviceState;
    networkOperatorName = await telephony.networkOperatorName;
    signalStrengths = await telephony.signalStrengths;

    bool gsmWorking =
        simState == SimState.READY &&
        phoneType == PhoneType.GSM &&
        serviceState == ServiceState.IN_SERVICE &&
        signalStrengths.isNotEmpty &&
        networkOperatorName != null &&
        networkOperatorName!.isNotEmpty;

    setState(() {
      status = gsmWorking ? "GSM Working Properly" : "GSM Not Fully Functional";
    });
  }

  void checkSimPresence(Telephony telephony) async {
    final simState = await telephony.simState;

    if (simState != SimState.READY) {
      // Show a dialog or snackbar
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("SIM Card Not Detected"),
          content: Text("Please insert a SIM card to check GSM functionality."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      checkGSMStatus();
    }
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GSM Diagnostic Tool")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Status: $status",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            infoRow("SIM State", simState?.name ?? "Unknown"),
            infoRow("Phone Type", phoneType?.name ?? "Unknown"),
            infoRow("Service State", serviceState?.name ?? "Unknown"),
            infoRow("Network Operator", networkOperatorName ?? "Unknown"),
            infoRow("Signal Strength Count", signalStrengths.length.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => checkSimPresence(telephony),
              child: const Text("Re-check Status"),
            ),
          ],
        ),
      ),
    );
  }
}
