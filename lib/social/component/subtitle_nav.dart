import 'package:dimple/common/const/colors.dart';
import 'package:dimple/social/component/friends_list_section.dart';
import 'package:dimple/social/view/freinds.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:dimple/common/component/submit_button.dart';

import 'friends_list_section.dart';

class Subtitlenav extends StatelessWidget {
  final String title;
  final String routeName;

  const Subtitlenav({Key? key, required this.title, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 280.0,
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // if (GoRouter.of(context) != null) {
              //   context.goNamed(routeName);
              // } else {
              //   print('GoRouter not found in context');
              // }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendsScreen()),
              );

            },
          )
        ],
      );
  }
}
