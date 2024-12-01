import 'package:dimple/common/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimple/calendar/config/app_config.dart';

void main() {
  // 실제 서버 사용시
  // AppConfig.environment = Environment.production;
  
  // 목 서버 사용시
  AppConfig.environment = Environment.mock;
  
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context,ref) {
    // final router = ref.watch(routerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootTab(),
    );
      //   .router(
      // debugShowCheckedModeBanner: false,
      // routerConfig: router,
      // );
  }
}