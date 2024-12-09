import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Friend {
  final String name;
  final String profileImage;
  final String distance;  // 자기소개 필드 추가

  Friend({
    required this.name,
    required this.profileImage,
    required this.distance,
  });

// TODO: API 연동시 JSON 파싱을 위한 팩토리 생성자 추가
// factory Friend.fromJson(Map<String, dynamic> json) {
//   return Friend(
//     name: json['name'],
//     profileImage: json['profile_image'],
//     introduction: json['introduction'],
//   );
// }
}

// TODO: API 연동시 실제 API 호출로 변경
final friendsProvider = FutureProvider<List<Friend>>((ref) async {
  await Future.delayed(Duration(seconds: 1));
  return [
    Friend(
      name: '마루',
      profileImage: 'assets/img/banreou.png',
      distance: '1.2km',
    ),
    Friend(
      name: '초코',
      profileImage: 'assets/img/banreou.png',
      distance: '0.8km',
    ),
    Friend(
      name: '멍멍이',
      profileImage: 'assets/img/banreou.png',
      distance: '1.4km',
    ),
  ];
});

class FriendProfileSection extends ConsumerWidget {
  const FriendProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendsProvider);

    return friendsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text('친구 목록을 불러오는데 실패했습니다: $error'),
      ),
      data: (friends) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: friends.map((friend) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,  // 크기 조절
                    backgroundImage: AssetImage(friend.profileImage),
                    // TODO: API 연동시 네트워크 이미지로 변경
                    // backgroundImage: NetworkImage(friend.profileImage),
                  ),
                  SizedBox(height: 8),
                  Text(
                    friend.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    friend.distance,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ),
    );
  }
}