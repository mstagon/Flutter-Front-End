import 'package:dimple/user/view_model/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref){
  final provider = ref.read(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    routes: provider.routes,
    redirect: provider.redirectLogic,
    refreshListenable: provider,
  );
});