import 'package:dimple/chatbot/view/chatbot_screen.dart';
import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:dimple/dashboard/view/dash_board_screen.dart';
import 'package:dimple/map/view/map_screen.dart';
import 'package:dimple/social/view/social_screen.dart';
import 'package:dimple/user/view/mypage_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget  {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          DashBoardScreen(),
          MapScreen(),
          ChatbotScreen(),
          SocialScreen(),
          MypageScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (int index){
          controller.animateTo(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_walk),label: '산책'),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: '챗봇'),
          BottomNavigationBarItem(icon: Icon(Icons.social_distance),label: '소셜'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: '마이페이지'),
        ],
      ),
    );
  }
}
