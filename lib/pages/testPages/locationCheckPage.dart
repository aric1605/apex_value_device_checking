import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationCheckPage extends StatefulWidget {
  const LocationCheckPage({super.key});

  @override
  State<LocationCheckPage> createState() => _LocationCheckPageState();
}

class _LocationCheckPageState extends State<LocationCheckPage> {
  String locationStatus = "Checking...";
  bool locationOff = false;

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationStatus = "❌ Location services are OFF";
        locationOff = true;
      });
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationStatus = "❌ Location permission denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationStatus =
            "❌ Location permission permanently denied. Enable in settings.";
      });
      return;
    }

    // Fetch actual location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      setState(() {
        locationStatus =
            "✅ Location working:\n"
            "Lat: ${position.latitude}, Lng: ${position.longitude}\n"
            "📍 ${place.locality}, ${place.administrativeArea}, ${place.country}";
        locationOff = false;
      });
    } catch (e) {
      setState(() {
        locationStatus =
            "⚠️ Location service ON but could not get location: $e";
      });
    }
  }

  Future<void> _openLocationSettings() async {
    bool opened = await Geolocator.openLocationSettings();
    if (opened) {
      _checkLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Check")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              locationStatus,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (locationOff)
              ElevatedButton(
                onPressed: _openLocationSettings,
                child: const Text("Turn On Location"),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkLocation,
              child: const Text("Recheck Location"),
            ),
          ],
        ),
      ),
    );
  }
}
