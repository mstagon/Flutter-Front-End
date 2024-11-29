import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/dog.dart';
import '../models/walk_record.dart';

class WalkRecordRepository {
  final Dio _dio;
  
  WalkRecordRepository(this._dio);

  Future<void> saveWalkRecord(WalkRecord record) async {
    try {
      // 산책 기록 저장 API 호출
      final response = await _dio.post(
        '/api/walk-records',
        data: record.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('산책 기록 저장에 실패했습니다.');
      }

      // 각 강아지별 배변 기록 저장
      for (final entry in record.toiletRecords.entries) {
        final dogId = entry.key;
        final toiletRecords = entry.value;

        await _dio.post(
          '/api/dogs/$dogId/toilet-records',
          data: {
            'walkRecordId': record.id,
            'records': toiletRecords.map((r) => r.toJson()).toList(),
          },
        );
      }

      // 각 강아지별 칼로리 기록 저장
      for (final dog in record.dogs) {
        await _dio.post(
          '/api/dogs/${dog.id}/activity-records',
          data: {
            'walkRecordId': record.id,
            'calories': _calculateDogCalories(dog, record.distance),
            'date': record.endTime.toIso8601String(),
          },
        );
      }
    } catch (e) {
      print('산책 기록 저장 중 오류 발생: $e');
      throw Exception('산책 기록 저장에 실패했습니다.');
    }
  }

  Future<void> updateCurrentLocation(String walkRecordId, LatLng location) async {
    try {
      await _dio.post(
        '/api/walk-records/$walkRecordId/locations',
        data: {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      print('위치 업데이트 중 오류 발생: $e');
      // 실시간 위치 업데이트는 실패해도 산책 진행에 영향을 주지 않도록 처리
    }
  }

  double _calculateDogCalories(Dog dog, double distance) {
    // 강아지별 칼로리 계산 로직
    return distance * 100;
  }
}

// Dio provider 설정
final dioProvider = Provider((ref) {
  final dio = Dio();
  
  // 기본 설정
  dio.options.baseUrl = 'https://your-api-endpoint.com'; // 실제 API 엔드포인트로 변경
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  
  // 인터셉터 추가 (예: 토큰 추가)
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // 토큰 추가
      options.headers['Authorization'] = 'Bearer your-token-here';
      return handler.next(options);
    },
  ));

  return dio;
});

// Repository provider 설정
final walkRecordRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return WalkRecordRepository(dio);
}); 