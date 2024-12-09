import 'package:dimple/common/layout/default_layout.dart';
import 'package:dimple/user/component/menstruation_container.dart';
import 'package:flutter/material.dart';

class MenstruationDetailScreen3 extends StatefulWidget {
  const MenstruationDetailScreen3({super.key});

  @override
  State<MenstruationDetailScreen3> createState() =>
      _MenstruationDetailScreen2State();
}

class _MenstruationDetailScreen2State extends State<MenstruationDetailScreen3> {
  int _currentValue = 7;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: MenstruationContainer(
        title: '주기길이가 보통\n어떻게 됩니까?',
        currentValue: _currentValue,
        buttonTitle: '완료',
        onChanged: (value){
          _currentValue = value;
        },
        onTap: (){

        },
      ),
    );
  }
}
