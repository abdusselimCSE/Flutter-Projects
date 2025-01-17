import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/*
* GPS -> current location - lat lng
* GPS service permission
* GPS service on/off
* get data from GPS
* */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? myPosition;

  @override
  void initState() {
    super.initState();
    listenCurrentPosition();
  }

  Future<void> listenCurrentPosition() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnabled = await checkGPSserviceEnabled();
      if (isServiceEnabled) {
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            // timeLimit: Duration(seconds: 5),
            distanceFilter: 10,
            accuracy: LocationAccuracy.bestForNavigation,
          ),
        ).listen((pos) {
          print(pos);
        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future<void> getCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnabled = await checkGPSserviceEnabled();
      if (isServiceEnabled) {
        Position position = await Geolocator.getCurrentPosition();
        myPosition = position;
        setState(() {});
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkGPSserviceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My current location:\n$myPosition",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: const Text("Get current Location"),
            ),
          ],
        ),
      ),
    );
  }
}
