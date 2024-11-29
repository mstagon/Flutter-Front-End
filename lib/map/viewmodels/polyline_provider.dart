import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final polylineCoordinatesProvider = StateNotifierProvider<PolylineProvider, List<LatLng>>(
      (ref) => PolylineProvider(),
);

class PolylineProvider extends StateNotifier<List<LatLng>> {
  PolylineProvider() : super([]);

  void addPoint(LatLng point) {
    state = [...state, point];
  }

  void clear() {
    state = [];
  }
}