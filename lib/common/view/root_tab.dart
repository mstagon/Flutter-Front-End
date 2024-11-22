import 'package:dimple/chatbot/view/chatbot_screen.dart';
import 'package:dimple/common/const/colors.dart';
import 'package:dimple/dashboard/view/dash_board_screen.dart';
import 'package:dimple/map/view/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class RootTab extends StatelessWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: DashBoardScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Icon(Icons.home),
            title: "홈",
          ),
        ),
        PersistentTabConfig(
          screen: MapScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Icon(Icons.directions_walk),
            title: "산책",
          ),
        ),
        // pushScreen(context, screen: ChatbotScreen(),withNavBar: false),
        PersistentTabConfig(
          screen: ChatbotScreen(),
          item: ItemConfig(
            activeForegroundColor: PRIMARY_COLOR,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/img/banreou.png',fit: BoxFit.cover,),
            ),
            title: "챗봇",
          ),
        ),
        PersistentTabConfig(
          screen: ChatbotScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Icon(Icons.social_distance),
            title: "소셜",
          ),
        ),
        PersistentTabConfig(
          screen: ChatbotScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.black,
            icon: Icon(Icons.person),
            title: "마이페이지",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style14BottomNavBar(
        navBarConfig: navBarConfig,
      ),

    );
  }
}
