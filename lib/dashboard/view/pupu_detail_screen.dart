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
            EvaluateAboutCircumstance(),
          ],
        ),
      ),
    );
  }
}

class EvaluateAboutCircumstance extends StatefulWidget {
  const EvaluateAboutCircumstance({super.key});

  @override
  State<EvaluateAboutCircumstance> createState() => _EvaluateAboutCircumstanceState();
}

class _EvaluateAboutCircumstanceState extends State<EvaluateAboutCircumstance> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: IMAGE_BACKGROUND_COLOR,
          radius: 40,
          child: Image.asset(
            'assets/img/banreou.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.width / 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey, width: 0.4), // 테두리 추가
            color: EVALUATE_ONELINE_COLOR,
          ),
          alignment: Alignment.center,
          child: Text('Lorem ipsum dolor sit amet consectetur radicalising elit. Sequi quia ea officiis, reiciendis ducimus magnam optio dignissimos quo ',maxLines: 10, overflow: TextOverflow.ellipsis,),
        ),
      ],
    );
  }
}
