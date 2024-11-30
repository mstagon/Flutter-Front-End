import 'package:dimple/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class SolutionCalendarScreen extends StatelessWidget {
  const SolutionCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(child: Center(child: Text('캘린더'),));
  }
}
