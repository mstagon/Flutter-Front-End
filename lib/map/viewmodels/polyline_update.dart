import 'package:dimple/map/models/walk_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'position_provider.dart';
import 'polyline_provider.dart';
import 'walkstate_provider.dart';

final polylineUpdaterProvider = StreamProvider<void>((ref) async* {
  final positionStream = ref.watch(positionProvider.stream);
  
  await for (final position in positionStream) {
    final state = ref.read(walkStateProvider);
    
    if (state == WalkState.riding && position != null) {
      final polylineNotifier = ref.read(polylineCoordinatesProvider.notifier);
      
      final latLng = LatLng(position.latitude, position.longitude);
      polylineNotifier.addPoint(latLng);
    }
  }
});