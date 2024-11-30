import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';

class EvaluateAboutCircumstance extends StatelessWidget {
  final String img;
  final String evalText;

  const EvaluateAboutCircumstance({super.key, required this.img, required this.evalText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey, width: 0.4), // 테두리 추가
        color: ONELINE_BACKGROUND_COLOR,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: IMAGE_BACKGROUND_COLOR,
            radius: 40,
            child: Image.asset(
              img,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.width / 5,
            ),
            alignment: Alignment.center,
            child: Text(evalText,maxLines: 10, overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    );
  }
}