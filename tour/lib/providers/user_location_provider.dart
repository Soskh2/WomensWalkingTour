import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  bool _isTracking = false;
  bool get isTracking => _isTracking;

  // Method to start tracking location in real-time
  void startLocationTracking() async {
    if (_isTracking) return;

    _isTracking = true;
    notifyListeners();

    // Request location permission and get the current position
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle case when the user has disabled location services
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // Handle the case where permission is denied
      return;
    }

    // Start listening to location updates
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,) // Minimum distance (in meters) between location updates
    ).listen((Position position) {
      _currentPosition = position;
      notifyListeners(); // Notify listeners to update UI
    });
  }

  // Method to stop location tracking
  void stopLocationTracking() {
    _isTracking = false;
    notifyListeners();
  }
}
