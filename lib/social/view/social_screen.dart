import 'package:dimple/social/component/conversation.dart';
import 'package:dimple/social/component/subtitle_nav.dart';
import 'package:flutter/material.dart';

import '../component/friendsprofile.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('소셜')),
      body: Column(
        children: [
          Subtitlenav(
            title: "친구",
            routeName: 'friends',
          ),
          FriendProfileSection(),
          Divider(),
          Subtitlenav(
            title: "대화",
            routeName: 'conversation',
          ),
          ConversationListSection(),
        ],
      ),
    );
  }
}
