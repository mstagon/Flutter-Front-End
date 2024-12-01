import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/dog.dart';
import '../models/walk_record.dart';
import 'dart:async';
import 'dart:math';

class WalkRecordNotifier extends StateNotifier<WalkRecord?> {
  WalkRecordNotifier() : super(null);
  DateTime? _startTime;
  Timer? _timer;
  
  void startWalk(List<Dog> dogs) {
    _startTime = DateTime.now();
    state = WalkRecord(
      id: DateTime.now().toString(),
      startTime: _startTime!,
      endTime: _startTime!,
      distance: 0,
      duration: Duration.zero,
      calories: 0,
      route: [],
      dogs: dogs,
    );

    // 1초마다 duration 업데이트
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (state != null) {
        state = WalkRecord(
          id: state!.id,
          startTime: state!.startTime,
          endTime: DateTime.now(),
          distance: state!.distance,
          duration: DateTime.now().difference(_startTime!),
          calories: state!.calories,
          route: state!.route,
          dogs: state!.dogs,
          toiletRecords: state!.toiletRecords,
        );
      }
    });
  }

  void updateDistance(List<LatLng> route) {
    if (state == null || route.isEmpty) return;

    double totalDistance = 0;
    for (int i = 0; i < route.length - 1; i++) {
      totalDistance += _calculateDistance(
        route[i].latitude,
        route[i].longitude,
        route[i + 1].latitude,
        route[i + 1].longitude,
      );
    }

    state = WalkRecord(
      id: state!.id,
      startTime: state!.startTime,
      endTime: DateTime.now(),
      distance: totalDistance,
      duration: DateTime.now().difference(_startTime!),
      calories: _calculateTotalCalories(totalDistance, state!.duration),
      route: route,
      dogs: state!.dogs,
      toiletRecords: state!.toiletRecords,
    );
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // 지구 반경 (km)
    var dLat = _toRad(lat2 - lat1);
    var dLon = _toRad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRad(lat1)) * cos(_toRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRad(double deg) {
    return deg * (pi / 180);
  }

  int _calculateTotalCalories(double distance, Duration duration) {
    // 모든 강아지의 칼로리 합계 계산
    return state?.dogs.fold(0, (sum, dog) => 
      sum! + (distance * 100).round()) ?? 0;
  }

  void addToiletRecord(ToiletRecord record) {
    if (state == null) return;

    final currentRecords = Map<String, List<ToiletRecord>>.from(state!.toiletRecords);
    if (!currentRecords.containsKey(record.dogId)) {
      currentRecords[record.dogId] = [];
    }
    currentRecords[record.dogId]!.add(record);

    state = WalkRecord(
      id: state!.id,
      startTime: state!.startTime,
      endTime: state!.endTime,
      distance: state!.distance,
      duration: state!.duration,
      calories: state!.calories,
      route: state!.route,
      dogs: state!.dogs,
      toiletRecords: currentRecords,
    );
  }

  Map<String, ToiletSummary> getToiletSummary() {
    if (state == null) return {};

    final summary = <String, ToiletSummary>{};
    state!.toiletRecords.forEach((dogId, records) {
      final poopCount = records.where((r) => r.type == ToiletType.poop).length;
      final peeCount = records.where((r) => r.type == ToiletType.pee).length;
      summary[dogId] = ToiletSummary(poopCount: poopCount, peeCount: peeCount);
    });
    return summary;
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    _startTime = null;
    state = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class ToiletSummary {
  final int poopCount;
  final int peeCount;

  ToiletSummary({
    required this.poopCount,
    required this.peeCount,
  });
}

final walkRecordProvider = StateNotifierProvider<WalkRecordNotifier, WalkRecord?>((ref) {
  return WalkRecordNotifier();
});