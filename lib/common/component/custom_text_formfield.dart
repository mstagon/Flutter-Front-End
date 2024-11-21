import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField<T> extends StatelessWidget {
  final bool autofocus;
  final ValueChanged<T>? onChanged;
  final String labelText;
  final bool isNumber;
  final double size;

  const CustomTextFormField({
    required this.onChanged,
    this.autofocus = false,
    super.key,
    required this.labelText,
    this.isNumber = false,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(
        color: Color(0xFFF3F2F2),
        width: 1.0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          width: size,
          height: 50,
          child: TextFormField(
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            cursorColor: PRIMARY_COLOR,
            autofocus: autofocus,
            onChanged: (value) {
              if (isNumber) {
                onChanged?.call(double.tryParse(value) as T);
              } else {
                onChanged?.call(value as T);
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              fillColor: Color(0xFFFBFBFB),
              // true는 배경색 있음 false는 없음
              filled: false,
              border: baseBorder,
              enabledBorder: baseBorder,
              focusedBorder: baseBorder.copyWith(
                  borderSide: baseBorder.borderSide.copyWith(
                color: PRIMARY_COLOR,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
