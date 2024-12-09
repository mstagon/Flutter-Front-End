import 'package:dimple/social/component/friends_list_section.dart';
import 'package:dimple/social/component/subtitle_nav.dart';
import 'package:flutter/material.dart';

import '../component/friends_list_section.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("친구"),),
      body: FriendsListSection(),
    );
  }
}
