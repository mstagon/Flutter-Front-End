import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dog.dart';

class WalkRecord {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final double distance; // km
  final Duration duration;
  final int calories;
  final List<LatLng> route;
  final List<Dog> dogs;
  final Map<String, List<ToiletRecord>> toiletRecords; // dogId를 key로 사용

  WalkRecord({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.duration,
    required this.calories,
    required this.route,
    required this.dogs,
    this.toiletRecords = const {},
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'distance': distance,
    'duration': duration.inSeconds,
    'calories': calories,
    'route': route.map((latLng) => {
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
    }).toList(),
    'dogs': dogs.map((dog) => dog.id).toList(),
    'toiletRecords': toiletRecords.map((dogId, records) => MapEntry(
      dogId,
      records.map((record) => record.toJson()).toList(),
    )),
  };
}

class ToiletRecord {
  final String dogId;
  final DateTime time;
  final LatLng location;
  final ToiletType type;

  ToiletRecord({
    required this.dogId,
    required this.time,
    required this.location,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'dogId': dogId,
    'time': time.toIso8601String(),
    'location': {
      'latitude': location.latitude,
      'longitude': location.longitude,
    },
    'type': type.toString(),
  };
}

enum ToiletType {
  pee,
  poop,
} 