import 'dart:typed_data';

import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dog.dart';
import '../providers/dogs_provider.dart';
import '../providers/selected_dogs_provider.dart';

class WalkStartDialog extends ConsumerWidget {
  const WalkStartDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dogs = ref.watch(dogsProvider);
    final selectedDogs = ref.watch(selectedDogsProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '함께 산책할 반려견을 선택하세요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...dogs.map((dog) => CheckboxListTile(
              title: Text(dog.name),
              value: selectedDogs.contains(dog),
              checkColor: Colors.white,
              activeColor: PRIMARY_COLOR,
              onChanged: (bool? value) {
                if (value == true) {
                  ref.read(selectedDogsProvider.notifier).addDog(dog);
                } else {
                  ref.read(selectedDogsProvider.notifier).removeDog(dog);
                }
              },
            )).toList(),
            SizedBox(height: 16),
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
              onPressed: selectedDogs.isNotEmpty
                  ? () {
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Text('선택 완료'),
            ),
          ],
        ),
      ),
    );
  }
} 