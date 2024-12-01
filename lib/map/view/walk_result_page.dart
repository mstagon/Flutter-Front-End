import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/walk_record.dart';
import '../models/dog.dart';
import '../models/walk_state.dart';
import '../viewmodels/polyline_provider.dart';
import '../viewmodels/walk_record_provider.dart';
import '../viewmodels/walkstate_provider.dart';
import '../providers/selected_dogs_provider.dart';

class WalkResultPage extends ConsumerWidget {
  final WalkRecord walkRecord;

  const WalkResultPage({
    Key? key,
    required this.walkRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 시작과 끝 지점 마커 생성
    final Set<Marker> markers = {
      if (walkRecord.route.isNotEmpty) ...[
        // 시작 지점 마커
        Marker(
          markerId: MarkerId('startPoint'),
          position: walkRecord.route.first,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: '시작 지점'),
        ),
        // 종료 지점 마커
        Marker(
          markerId: MarkerId('endPoint'),
          position: walkRecord.route.last,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: '종료 지점'),
        ),
      ],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('산책 결과'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 지도 표시
            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _getCenterLatLng(walkRecord.route),
                  zoom: _calculateZoomLevel(walkRecord.route),
                ),
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                polylines: {
                  Polyline(
                    polylineId: PolylineId('walkPath'),
                    points: walkRecord.route,
                    color: Colors.blue,
                    width: 5,
                    startCap: Cap.roundCap,
                    endCap: Cap.roundCap,
                    jointType: JointType.round,
                  ),
                },
                markers: markers, // 마커 추가
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 산책 요약 정보
                  _buildSummaryCard(),
                  SizedBox(height: 20),
                  // 강아지별 상세 정보
                  Text(
                    '반려견별 기록',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  ...walkRecord.dogs.map((dog) => _buildDogCard(dog)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFFD747),
            foregroundColor: Colors.black,
            minimumSize: Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            // 모든 상태 초기화
            ref.read(walkStateProvider.notifier).state = WalkState.before;
            ref.read(walkRecordProvider.notifier).reset();
            ref.read(polylineCoordinatesProvider.notifier).clear();
            ref.read(selectedDogsProvider.notifier).clearDogs();
            
            // 루트 탭으로 이동
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text(
            '확인',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            '총 산책 거리',
            '${walkRecord.distance.toStringAsFixed(2)} km',
          ),
          SizedBox(height: 16),
          _buildSummaryRow(
            '총 산책 시간',
            '${walkRecord.duration.inMinutes} 분',
          ),
        ],
      ),
    );
  }

  Widget _buildDogCard(Dog dog) {
    final toiletRecords = walkRecord.toiletRecords[dog.id] ?? [];
    final poopCount = toiletRecords.where((r) => r.type == ToiletType.poop).length;
    final peeCount = toiletRecords.where((r) => r.type == ToiletType.pee).length;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // 강아지 정보 헤더
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(dog.imageUrl),
              ),
              SizedBox(width: 12),
              Text(
                dog.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 배변 활동 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildToiletInfo('💩', poopCount),
              _buildToiletInfo('💦', peeCount),
            ],
          ),
          SizedBox(height: 16),
          // 소모 칼로리
          _buildSummaryRow(
            '소모 칼로리',
            '${(walkRecord.distance * 100).round()} kcal',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildToiletInfo(String emoji, int count) {
    return Column(
      children: [
        Text(
          emoji,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 4),
        Text(
          '$count회',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  LatLng _getCenterLatLng(List<LatLng> route) {
    if (route.isEmpty) return LatLng(37.5665, 126.9780);

    double sumLat = 0;
    double sumLng = 0;
    for (var point in route) {
      sumLat += point.latitude;
      sumLng += point.longitude;
    }
    return LatLng(sumLat / route.length, sumLng / route.length);
  }

  double _calculateZoomLevel(List<LatLng> route) {
    if (route.isEmpty) return 13;

    double minLat = route[0].latitude;
    double maxLat = route[0].latitude;
    double minLng = route[0].longitude;
    double maxLng = route[0].longitude;

    for (var point in route) {
      minLat = point.latitude < minLat ? point.latitude : minLat;
      maxLat = point.latitude > maxLat ? point.latitude : maxLat;
      minLng = point.longitude < minLng ? point.longitude : minLng;
      maxLng = point.longitude > maxLng ? point.longitude : maxLng;
    }

    double latDiff = maxLat - minLat;
    double lngDiff = maxLng - minLng;
    double maxDiff = latDiff > lngDiff ? latDiff : lngDiff;

    // 간단한 줌 레벨 계산 로직
    if (maxDiff <= 0.01) return 15;
    if (maxDiff <= 0.05) return 13;
    if (maxDiff <= 0.1) return 12;
    return 10;
  }
} 