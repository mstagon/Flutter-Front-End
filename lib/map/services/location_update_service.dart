import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationUpdateService {
  static const Duration updateInterval = Duration(seconds: 30);
  Timer? _timer;

  void startPeriodicUpdates(Position position) {
    _timer?.cancel();
    _timer = Timer.periodic(updateInterval, (timer) {
      _sendLocationToBackend(position);
    });
  }

  void stopPeriodicUpdates() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _sendLocationToBackend(Position position) async {
    // TODO: API 호출하여 현재 위치 전송
  }
} 