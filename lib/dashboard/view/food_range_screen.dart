import 'package:dimple/common/component/evaluate_component.dart';
import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FoodRangeScreen extends StatefulWidget {
  const FoodRangeScreen({super.key});

  @override
  State<FoodRangeScreen> createState() => _FoodRangeScreenState();
}

class _FoodRangeScreenState extends State<FoodRangeScreen> {
  int _currentPeriodIndex = 0;

  final Map<int, int> _periodItemCount = {
    0: 4,   // 일요일
    1: 5,   // 월요일
    2: 3,   // 화요일
    3: 6,   // 수요일
    4: 4,   // 목요일
    5: 7,   // 금요일
    6: 2,   // 토요일
  };

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        centerTitle: true,
        title: Text('급여량'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ToggleSwitch(
                minHeight: 30,
                initialLabelIndex: _currentPeriodIndex,
                totalSwitches: 7,
                activeFgColor: Colors.black,
                activeBgColor: const [PRIMARY_COLOR],
                labels: const ['일', '월', '화', '수', '목', '금', '토'],
                onToggle: (index) {
                  if (index != null) {
                    setState(() {
                      _currentPeriodIndex = index;
                    });
                  }
                },
              ),
              const SizedBox(height: 30.0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _periodItemCount[_currentPeriodIndex],
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('12:40'),
                        const SizedBox(height: 3.0),
                        EvaluateAboutCircumstance(
                            img: 'assets/img/banreou.png',
                            evalText: '$index 번째 간식입니다'
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}