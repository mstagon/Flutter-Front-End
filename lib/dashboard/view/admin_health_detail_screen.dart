import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:dimple/dashboard/component/custom_bar_chart.dart';
import 'package:flutter/material.dart';

class AdminHealthDetailScreen extends StatefulWidget {
  const AdminHealthDetailScreen({super.key});

  @override
  State<AdminHealthDetailScreen> createState() =>
      _AdminHealthDetailScreenState();
}

class _AdminHealthDetailScreenState extends State<AdminHealthDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        centerTitle: true,
        title: Text('건강 관리'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.width / 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey, width: 0.4),
                // 테두리 추가
                color: EVALUATE_ONELINE_COLOR,
              ),
              alignment: Alignment.center,
              child: Text(
                '반려견의 체중, 운동량, 식사량 등을 분석한 개인화된 건강 관리 권고',
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.width / 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey, width: 0.4),
                // 테두리 추가
                color: EVALUATE_ONELINE_COLOR,
              ),
              alignment: Alignment.center,
              child: Text(
                '체중 관리를 위한 맞춤형 운동 계획 및 식이 가이드 제공',
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}