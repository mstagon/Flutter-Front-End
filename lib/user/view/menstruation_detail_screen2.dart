import 'package:dimple/common/layout/default_layout.dart';
import 'package:dimple/user/component/menstruation_container.dart';
import 'package:flutter/material.dart';
import 'package:dimple/common/component/submit_button.dart';

class MenstruationDetailScreen2 extends StatefulWidget {
  const MenstruationDetailScreen2({super.key});

  @override
  State<MenstruationDetailScreen2> createState() =>
      _MenstruationDetailScreen2State();
}

class _MenstruationDetailScreen2State extends State<MenstruationDetailScreen2> {
  int _currentValue = 30;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: MenstruationContainer(
        title: '생리가 보통 \n며칠 지속됩니까?',
        currentValue: _currentValue,
        buttonTitle: '다음',
        onChanged: (value) {
          setState(() {
            _currentValue = value;
          });
        },
        onTap: () {
          // 다음페이지 넘가야함.
        },
      ),
    );
  }
}
