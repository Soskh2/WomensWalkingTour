import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  bool _isTracking = false;
  bool get isTracking => _isTracking;

  Future<void> startLocationTracking() async {
    if (_isTracking) return;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle case when location services are disabled
      debugPrint('Location services are disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      debugPrint("No location permission");
    }

    else if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _isTracking = true;
      notifyListeners();

      Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) {
        _currentPosition = position;
        notifyListeners();
      });
    } else {
      debugPrint('Location permission denied');
    }
  }

  void stopLocationTracking() {
    _isTracking = false;
    notifyListeners();
  }
}
