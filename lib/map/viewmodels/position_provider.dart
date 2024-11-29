import 'dart:async';
import 'dart:math';

import 'package:dimple/map/viewmodels/polyline_provider.dart';
import 'package:dimple/map/viewmodels/walk_record_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/position_service.dart';
import '../repositories/walk_record_repository.dart';


class PositionController extends StateNotifier<Stream<Position>?> {
  final WalkRecordRepository _repository;
  final WalkRecordNotifier _walkRecordNotifier;
  final PolylineProvider _polylineProvider;
  StreamSubscription<Position>? _subscription;

  PositionController(
    this._repository, 
    this._walkRecordNotifier,
    this._polylineProvider,
  ) : super(null);

  void startListening() {
    final positionStream = PositionService().positionStream();
    _subscription = positionStream.listen((position) async {
      final currentRecord = _walkRecordNotifier.state;
      if (currentRecord != null) {
        final newPoint = LatLng(position.latitude, position.longitude);
        
        // 경로에 새 위치 추가
        _polylineProvider.addPoint(newPoint);
        
        // 거리 업데이트
        _walkRecordNotifier.updateDistance(_polylineProvider.state);
        
        // 백엔드에 현재 위치 전송
        await _repository.updateCurrentLocation(
          currentRecord.id,
          newPoint,
        );
      }
    });
    state = positionStream;
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
    state = null;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}


final positionControllerProvider = StateNotifierProvider<PositionController, Stream<Position>?>((ref) {
  final repository = ref.watch(walkRecordRepositoryProvider);
  final walkRecordNotifier = ref.watch(walkRecordProvider.notifier);
  final polylineProvider = ref.watch(polylineCoordinatesProvider.notifier);
  return PositionController(repository, walkRecordNotifier, polylineProvider);
});


final positionProvider = StreamProvider<Position>((ref) {
  final stream = ref.watch(positionControllerProvider);
  if (stream == null) {
    return Stream.empty();
  }
  return stream;
});