import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog.dart';

class DogsNotifier extends StateNotifier<List<Dog>> {
  DogsNotifier() : super([]) {
    // 초기 데이터 로드
    loadDogs();
  }

  Future<void> loadDogs() async {
    // TODO: 실제 API 호출로 대체
    // 임시 데이터
    state = [
      Dog(
        id: '1',
        name: '마루',
        imageUrl: 'https://example.com/maru.jpg',
        breed: '포메라니안',
        age: 3,
        weight: 4.5,
      ),
      Dog(
        id: '2',
        name: '확인',
        imageUrl: 'https://example.com/hwak.jpg',
        breed: '포메라니안',
        age: 2,
        weight: 3.8,
      ),
    ];
  }
}

final dogsProvider = StateNotifierProvider<DogsNotifier, List<Dog>>((ref) {
  return DogsNotifier();
}); 