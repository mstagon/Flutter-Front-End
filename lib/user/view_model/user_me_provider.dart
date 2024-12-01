import 'package:dimple/common/const/const.dart';
import 'package:dimple/common/secure_storage/secure_storage.dart';
import 'package:dimple/user/model/user_model.dart';
import 'package:dimple/user/repository/auth_repository.dart';
import 'package:dimple/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      authRepository: authRepository,
      repository: userMeRepository,
      storage: storage);
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(
          UserModelLoading(),
        ) {
    getMe();
  }

// 내 정보 가져오기
  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    try {
      final resp = await repository.getMe();
      state = resp;
    } catch (e, stack) {
      print(e);
      print(stack);

      state = null;
    }
  }

  Future<UserModelBase> login(
      {required clientId, required redirectUri, required kaKaoAuthUrl}) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
          clientId: clientId,
          redirectUri: redirectUri,
          kakaoAuthUrl: kaKaoAuthUrl,
      );

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      final userResp = await repository.getMe();
      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    // 두개를 동시에 시작함 -> 두개가 동시에 완료되면 await종료
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}
