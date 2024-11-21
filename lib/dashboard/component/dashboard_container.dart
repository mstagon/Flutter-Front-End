import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';

class DashboardContainer extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget child;

  const DashboardContainer(
      {super.key,
      required this.title,
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 0.4), // 테두리 추가
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: PRIMARY_COLOR, // 상단 노란색 배경
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: onTap,
                  icon: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
