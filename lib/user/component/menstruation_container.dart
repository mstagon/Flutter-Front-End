import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:dimple/common/component/submit_button.dart';

class MenstruationContainer extends StatelessWidget {
  final String title;
  final int currentValue;
  final String buttonTitle;
  final ValueChanged<int> onChanged;
  final VoidCallback onTap;

  const MenstruationContainer({super.key, required this.title, required this.currentValue, required this.buttonTitle, required this.onChanged, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120.0,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.0,
          ),
          Divider(),
          Expanded(
            child: NumberPicker(
              textMapper: (String s) {
                return s + '일';
              },
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              value: currentValue,
              minValue: 1,
              maxValue: 100,
              haptics: true,
              onChanged: onChanged,
            ),
          ),
          Divider(),
          SizedBox(
            height: 240.0,
          ),
          SubmitButton(
            text: buttonTitle,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
