import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  bool _isTracking = false;
  bool get isTracking => _isTracking;

  // Method to start tracking location in real-time
  Future<void> startLocationTracking() async {
    if (_isTracking) return;

    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle case when location services are disabled
      debugPrint('Location services are disabled');
      return;
    }

    // Check for location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      debugPrint("No location permission");
    }

    // If permission is granted, start location tracking
    else if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _isTracking = true;
      notifyListeners();

      // Start listening to location updates
      Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) {
        _currentPosition = position;
        notifyListeners(); // Notify listeners to update UI
      });
    } else {
      debugPrint('Location permission denied');
    }
  }

  // Method to stop location tracking
  void stopLocationTracking() {
    _isTracking = false;
    notifyListeners();
  }
}
