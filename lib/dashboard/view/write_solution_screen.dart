import 'package:dimple/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class WriteSolutionScreen extends StatelessWidget {
  const WriteSolutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('솔루션 작성하기'),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
