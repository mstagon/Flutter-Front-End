import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../services/position_service.dart';


// 위치 추적 상태를 관리하는 StateNotifier
class PositionController extends StateNotifier<Stream<Position>?> {
  PositionController() : super(null);
  final _positionService = PositionService();

  void startListening() {
    state = _positionService.positionStream();
  }

  void stopListening() {
    state = null;
  }
}

// 위치 추적 컨트롤러 provider
final positionControllerProvider = StateNotifierProvider<PositionController, Stream<Position>?>(
  (ref) => PositionController(),
);

// 위치 스트림 provider
final positionProvider = StreamProvider<Position>((ref) {
  final stream = ref.watch(positionControllerProvider);
  if (stream == null) {
    return Stream.empty();
  }
  return stream;
});