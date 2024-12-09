import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/chat.dart';

class Conversation {
  final String friendName;
  final String profileImage;
  final String lastMessage;
  //final DateTime lastMessageTime;  // 시간 표시를 위해 추가

  Conversation({
    required this.friendName,
    required this.profileImage,
    required this.lastMessage,
    //required this.lastMessageTime,
  });

// TODO: API 연동시 JSON 파싱을 위한 팩토리 생성자 추가
// factory Conversation.fromJson(Map<String, dynamic> json) {
//   return Conversation(
//     friendName: json['friend_name'],
//     profileImage: json['profile_image'],
//     lastMessage: json['last_message'],
//     lastMessageTime: DateTime.parse(json['last_message_time']),
//   );
// }
}

// TODO: API 연동시 실제 API 호출로 변경
final conversationsProvider = FutureProvider<List<Conversation>>((ref) async {
  await Future.delayed(Duration(seconds: 1));
  return [
    Conversation(
      friendName: '마루',
      profileImage: 'assets/img/banreou.png',
      lastMessage: '산책 가고 싶어요!',
      //lastMessageTime: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    Conversation(
      friendName: '초코',
      profileImage: 'assets/img/banreou.png',
      lastMessage: '간식 주세요~',
      //lastMessageTime: DateTime.now().subtract(Duration(hours: 1)),
    ),
    Conversation(
      friendName: '멍멍이',
      profileImage: 'assets/img/banreou.png',
      lastMessage: '잘 자요!',
      //lastMessageTime: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
});

class ConversationListSection extends ConsumerWidget {
  const ConversationListSection({Key? key}) : super(key: key);

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else {
      return '${difference.inDays}일 전';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsProvider);

    return conversationsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text('대화 목록을 불러오는데 실패했습니다: $error'),
      ),
      data: (conversations) => ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(conversation.profileImage),
            ),
            title: Text(
              conversation.friendName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              conversation.lastMessage,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    friendName: conversation.friendName,
                    subtitle: '푸들',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}