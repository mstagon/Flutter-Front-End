import 'package:dimple/map/models/walk_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/position_service.dart';
import '../viewmodels/markers_provider.dart';
import '../viewmodels/polyline_update.dart';
import '../viewmodels/position_provider.dart';
import '../viewmodels/polyline_provider.dart';
import '../viewmodels/walkstate_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;
  double _currentZoom = 17.0;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    final polylineCoordinates = ref.watch(polylineCoordinatesProvider);
    //final markers = ref.watch(markerProvider);
    final ridingState = ref.watch(walkStateProvider);

    ref.listen(polylineUpdaterProvider, (previous, next) {
      next.whenData((value) {
        // 필요한 경우 여기서 추가 작업 수행
      });
    });

    ref.listen(positionProvider, (previous, next) {
      next.whenData((position) async {
        if (ridingState == WalkState.riding && _mapController != null) {
          await _mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: _currentZoom,
                tilt: 0,
                bearing: 0,
              ),
            ),
          );
        }
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text('Polyline Tracking')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.5665, 126.9780),
          zoom: 17.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        //markers: markers,
        polylines: {
          Polyline(
            polylineId: PolylineId('tracking'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        onCameraMove: (CameraPosition position) {
          _currentZoom = position.zoom;
        },
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        compassEnabled: false,
        mapToolbarEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          ridingState == WalkState.riding ? Icons.pause : Icons.play_arrow,
        ),
        onPressed: () {
          final ridingNotifier = ref.read(walkStateProvider.notifier);
          if (ridingState == WalkState.riding) {
            ridingNotifier.state = WalkState.paused;
            ref.read(positionControllerProvider.notifier).stopListening();
          } else {
            if (ridingState == WalkState.before) {
              ref.read(positionControllerProvider.notifier).startListening();
            }
            ridingNotifier.state = WalkState.riding;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}