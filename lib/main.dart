import 'package:dimple/common/view/root_tab.dart';
import 'package:dimple/user/view/dog_register_screen1.dart';
import 'package:dimple/user/view/dog_register_screen2.dart';
import 'package:dimple/user/view/menstruation_detail_screen2.dart';
import 'package:dimple/user/view/menstruation_detail_screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
void main() {
  runApp(
      // ProviderScope(MyApp()),
    MyApp(),
  );
}

class MyApp extends ConsumerWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context,ref) {
    // final router = ref.watch(routerProvider);
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: const Color(0xffEE5366),
      //   colorScheme:
      //   ColorScheme.fromSwatch(accentColor: const Color(0xffEE5366)),
      // ),
      debugShowCheckedModeBanner: false,
      home: RootTab(),
    );
      //   .router(
      // debugShowCheckedModeBanner: false,
      // routerConfig: router,
      // );
  }
}