import 'package:dimple/common/component/evaluate_component.dart';
import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:dimple/dashboard/component/custom_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PupuDetailScreen extends StatefulWidget {
  const PupuDetailScreen({super.key});

  @override
  State<PupuDetailScreen> createState() => _PupuDetailScreenState();
}

class _PupuDetailScreenState extends State<PupuDetailScreen> {
  ChartPeriod _currentPeriod = ChartPeriod.day;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        centerTitle: true,
        title: Text('배변활동'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleSwitch(
              minHeight: 30,
              initialLabelIndex: _currentPeriod.index,
              totalSwitches: 3,
              activeFgColor: Colors.black,
              activeBgColor: const [PRIMARY_COLOR],
              labels: const ['1주', '1개월', '1년'],
              onToggle: (index) {
                if (index != null) {
                  setState(() {
                    _currentPeriod = ChartPeriod.values[index];
                  });
                }
              },
            ),
            const SizedBox(height: 10.0,),
            // 이벤트에 따른 글 요일 날짜 변경
            CustomBarChart(
              period: _currentPeriod,
            ),
            const SizedBox(height: 20.0,),
            EvaluateAboutCircumstance(img: 'assets/img/banreou.png', evalText: '배변에 대한 한줄평'),
          ],
        ),
      ),
    );
  }
}