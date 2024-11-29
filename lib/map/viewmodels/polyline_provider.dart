import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final polylineCoordinatesProvider = StateNotifierProvider<PolylineProvider, List<LatLng>>(
      (ref) => PolylineProvider(),
);

class PolylineProvider extends StateNotifier<List<LatLng>> {
  PolylineProvider() : super([]);

  void addPoint(LatLng point) {
    if (state.isEmpty) {
      state = [point];
      return;
    }

    // 마지막 포인트와 새 포인트 사이의 중간 포인트 생성
    final lastPoint = state.last;
    final middleLat = (lastPoint.latitude + point.latitude) / 2;
    final middleLng = (lastPoint.longitude + point.longitude) / 2;
    final middlePoint = LatLng(middleLat, middleLng);

    state = [
      ...state,
      middlePoint,  // 중간 포인트 추가
      point,
    ];
  }

  void clear() {
    state = [];
  }
}