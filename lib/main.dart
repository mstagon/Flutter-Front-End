import 'package:dimple/common/view/root_tab.dart';
import 'package:dimple/common/view_model/go_router.dart';
import 'package:dimple/user/view/dog_register_screen1.dart';
import 'package:dimple/user/view/dog_register_screen2.dart';
import 'package:dimple/user/view/menstruation_detail_screen2.dart';
import 'package:dimple/user/view/menstruation_detail_screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
void main() {
  runApp(
      ProviderScope(child: MyApp()),
    // MyApp(),
  );
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      );
  }
}