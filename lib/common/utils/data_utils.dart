import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataUtils{
  static DateTime stringToDateTime(String value){
    return DateTime.parse(value);
  }

  static String pathToUrl(String value){
    return 'http://$ip/$value';
  }

  static void showCenterNumberPicker(BuildContext context, int initialNumber, Function(int) onNumberSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedNumber = initialNumber;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text("취소",
                          style: TextStyle(color: Colors.red, fontSize: 16)),
                    ),
                    GestureDetector(
                      onTap: () {
                        onNumberSelected(selectedNumber);
                        Navigator.pop(context);
                      },
                      child: const Text("완료",
                          style: TextStyle(color: Colors.blue, fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // 숫자 선택기
                Expanded(
                  child: CupertinoPicker(
                    scrollController:
                    FixedExtentScrollController(initialItem: initialNumber),
                    itemExtent: 40.0,
                    onSelectedItemChanged: (int index) {
                      selectedNumber = index;
                    },
                    children: List<Widget>.generate(
                      31,
                          (int index) => Center(
                          child: Text(index.toString(),
                              style: const TextStyle(fontSize: 18))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showFoodPopUp(BuildContext context) {
    final TextEditingController feedController = TextEditingController();
    final FocusNode feedFocusNode = FocusNode();
    String feedTime = '';
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: Column(
              children: [
                Text(
                  '급여량 및 급여 시간 입력',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: feedController,
                    focusNode: feedFocusNode,
                    cursorColor: Colors.black,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'ex) 개사료 50g / 종이컵 사료 반컵',
                      fillColor: Color(0xFFFBFBFB),
                      filled: false,
                      border: baseBorder,
                      enabledBorder: baseBorder,
                      focusedBorder: baseBorder.copyWith(
                        borderSide: baseBorder.borderSide.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // 숫자 선택기
                Expanded(
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    onTimerDurationChanged: (value) {
                      String formattedTime =
                          '${value.inHours}:${value.inMinutes.remainder(60).toString().padLeft(2, '0')}';
                      feedTime = formattedTime;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      onPressed: () {
                        // api연동부분
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '저장',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}