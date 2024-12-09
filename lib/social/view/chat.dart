import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 메시지 데이터 모델
class ChatMessage {
  final String text;
  final bool isMine;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMine,
    required this.time,
  });

  // TODO: API 연동시 JSON 파싱을 위한 팩토리 생성자 추가
  // factory ChatMessage.fromJson(Map<String, dynamic> json) {
  //   return ChatMessage(
  //     text: json['text'],
  //     isMine: json['is_mine'],
  //     time: json['time'],
  //   );
  // }
}

// TODO: API 연동시 실제 API 호출로 변경
final chatMessagesProvider = FutureProvider<List<ChatMessage>>((ref) async {
  await Future.delayed(Duration(seconds: 1));
  return [
    ChatMessage(
      text: '너 산책 언제 갈거야?',
      isMine: false,
      time: '오후 05:26',
    ),
    ChatMessage(
      text: '물라 주인씨까가 안가ㅜㅜ',
      isMine: true,
      time: '오후 05:26',
    ),
    ChatMessage(
      text: '나네 주인 별로다~',
      isMine: false,
      time: '오후 05:26',
    ),
  ];
});

class ChatScreen extends ConsumerWidget {
  final String friendName;
  final String subtitle;

  ChatScreen({
    required this.friendName,
    this.subtitle = '푸들',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessagesAsync = ref.watch(chatMessagesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '대화',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          // 친구 프로필 섹션
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friendName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  '4살',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          // 메시지 목록
          Expanded(
            child: chatMessagesAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('메시지를 불러오는데 실패했습니다: $error'),
              ),
              data: (messages) => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: message.isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!message.isMine) ...[
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[300],
                          ),
                          SizedBox(width: 8),
                        ],
                        Column(
                          crossAxisAlignment: message.isMine
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: message.isMine
                                    ? Color(0xFFFFE69A)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(message.text),
                            ),
                            SizedBox(height: 4),
                            Text(
                              message.time,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // 입력창
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
