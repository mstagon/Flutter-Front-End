import 'package:geolocator/geolocator.dart';

Future<void> requestLocationPermission() async {
  LocationPermission permission;

  // 현재 권한 상태 확인
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // 권한 요청
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // 사용자가 권한을 거부한 경우
      throw Exception('위치 권한이 거부되었습니다.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // 사용자가 영구적으로 권한을 거부한 경우
    throw Exception('위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용하세요.');
  }

  // 위치 서비스가 활성화되어 있는지 확인
  final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationEnabled) {
    throw Exception('위치 서비스가 비활성화되어 있습니다. 설정에서 활성화하세요.');
  }
}