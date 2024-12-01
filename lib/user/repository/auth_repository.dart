import 'package:dimple/common/const/const.dart';
import 'package:dimple/common/dio/dio.dart';
import 'package:dimple/common/model/login_response.dart';
import 'package:dimple/common/model/token_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref){
  final dio = ref.watch(dioProvider);
  return AuthRepository(baseUrl: 'http://$ip/auth', dio: dio);
});


class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({required clientId, required redirectUri, required kakaoAuthUrl}) async {

    final resp = await dio.post('$baseUrl/login',
        options: Options(headers: {
          'authorization': 'Basic 1234123124123123',
        }));

    return LoginResponse.fromJson(resp.data);
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(headers: {
        'refreshToken': 'true',
      }),
    );
    return TokenResponse.fromJson(resp.data);
  }
}