import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final markerProvider = StateNotifierProvider<MarkerProvider, Set<Marker>>(
      (ref) => MarkerProvider(),
);

class MarkerProvider extends StateNotifier<Set<Marker>> {
  MarkerProvider() : super({});

  static const String currentLocationMarkerId = 'currentLocation';

  void updateMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId(currentLocationMarkerId),
      position: position,
      infoWindow: InfoWindow(title: '현재 위치'),
    );
    state = {marker};
  }

  void clearMarkers() {
    state = {};
  }
}