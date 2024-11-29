import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class PositionService {
  static final PositionService _instance = PositionService._internal();

 late final LocationSettings _locationSettings;

  static const int DISTANCE = 0;
  static const int DURATION_MILLISECONDS = 100;

  factory PositionService() => _instance;

  PositionService._internal() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: DISTANCE,
        forceLocationManager: true,
        intervalDuration: const Duration(milliseconds: DURATION_MILLISECONDS),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "백그라운드에서 위치를 수집 중입니다.",
          notificationTitle: "Tracking in Background",
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _locationSettings = AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        activityType: ActivityType.fitness,
        distanceFilter: DISTANCE,
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: false,
      );
    } else {
      _locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: DISTANCE,
      );
    }
  }

  Stream<Position> positionStream() {
    return Geolocator.getPositionStream(locationSettings: _locationSettings);
  }
}