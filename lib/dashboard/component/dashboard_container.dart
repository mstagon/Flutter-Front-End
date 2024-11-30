import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';

class DashboardContainer extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget child;
  final double? width;
  final bool? yIcon;

  const DashboardContainer({
    super.key,
    required this.title,
    required this.onTap,
    required this.child,
    this.width,
    this.yIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: 150,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey, width: 0.4), // 테두리 추가
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR, // 상단 대표 색상
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: yIcon == false
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (yIcon == false)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else ...[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: onTap,
                      icon: Icon(Icons.chevron_right),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
