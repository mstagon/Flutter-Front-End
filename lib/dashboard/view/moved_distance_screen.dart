import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MovedDistanceScreen extends StatelessWidget {
  const MovedDistanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 4,
              activeFgColor: Colors.black,
              activeBgColor: [
                PRIMARY_COLOR,
              ],
              labels: const ['1일', '1주', '1개월', '1년'],
              onToggle: (index){

              },
            ),
          ],
        ),
      ),
    );
  }
}
