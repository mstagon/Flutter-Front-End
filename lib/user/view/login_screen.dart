import 'package:dimple/common/const/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 177,),
            Container(
              child: Column(
                children: [
                  Image.asset('assets/img/banreou.png', width: 277, height: 277,),
                ],
              ),
            ),
            SizedBox(height: 181,),
            GestureDetector(child: Image.asset('assets/img/login/kakao.png',  width: 336, height: 56,),
              onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => KakaoLoginScreen()));
              },),
            SizedBox(height: 18,),
            GestureDetector(child: Image.asset('assets/img/login/google.png',  width: 336, height: 56,),
              onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleLoginScreen()));
              },),
          ],

        ),
      ),
    );
  }
}
