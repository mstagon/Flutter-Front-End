import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog.dart';
import '../models/walk_record.dart';

class ToiletRecordDialog extends ConsumerStatefulWidget {
  final List<Dog> walkingDogs;
  final Function(List<Dog>, ToiletType) onRecord;

  const ToiletRecordDialog({
    Key? key,
    required this.walkingDogs,
    required this.onRecord,
  }) : super(key: key);

  @override
  _ToiletRecordDialogState createState() => _ToiletRecordDialogState();
}

class _ToiletRecordDialogState extends ConsumerState<ToiletRecordDialog> {
  ToiletType selectedType = ToiletType.poop;
  List<Dog> selectedDogs = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "배변 활동을 누가 했나요?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // 배변 타입 선택
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTypeButton(ToiletType.poop, "💩"),
                SizedBox(width: 16),
                _buildTypeButton(ToiletType.pee, "💦"),
              ],
            ),
            SizedBox(height: 20),
            // 강아지 선택 그리드
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: widget.walkingDogs.map((dog) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedDogs.contains(dog)) {
                        selectedDogs.remove(dog);
                      } else {
                        selectedDogs.add(dog);
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(dog.imageUrl),
                          ),
                          if (selectedDogs.contains(dog))
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(dog.name),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("취소"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD747),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(160, 50),
                  ),
                  onPressed: selectedDogs.isEmpty ? null : () {
                    widget.onRecord(selectedDogs, selectedType);
                    Navigator.pop(context);
                  },
                  child: Text("기록하기"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(ToiletType type, String emoji) {
    return GestureDetector(
      onTap: () => setState(() => selectedType = type),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedType == type ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: selectedType == type ? Colors.blue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 