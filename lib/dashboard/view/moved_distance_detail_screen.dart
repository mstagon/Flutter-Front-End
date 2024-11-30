import 'package:dimple/common/component/evaluate_component.dart';
import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:dimple/dashboard/component/custom_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MovedDistanceDetailScreen extends StatefulWidget {
  const MovedDistanceDetailScreen({super.key});

  @override
  State<MovedDistanceDetailScreen> createState() => _MovedDistanceDetailScreenState();
}

class _MovedDistanceDetailScreenState extends State<MovedDistanceDetailScreen> {
  ChartPeriod _currentPeriod = ChartPeriod.day;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        centerTitle: true,
        title: Text('이동거리'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleSwitch(
              minHeight: 30,
              initialLabelIndex: _currentPeriod.index,
              totalSwitches: 4,
              activeFgColor: Colors.black,
              activeBgColor: const [PRIMARY_COLOR],
              labels: ['1일', '1주', '1개월', '1년'],
              onToggle: (index) {
                if (index != null) {
                  setState(() {
                    _currentPeriod = ChartPeriod.values[index];
                  });
                }
              },
            ),
            const SizedBox(height: 10.0,),
            CustomBarChart(
              period: _currentPeriod,
            ),
            const SizedBox(height: 20.0,),
            EvaluateAboutCircumstance(img: 'assets/img/banreou.png', evalText: '이동거리에 대한 한줄평'),
          ],
        ),
      ),
    );
  }
}


