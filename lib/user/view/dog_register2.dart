import 'package:flutter/material.dart';

class DogRegister2 extends StatefulWidget {
  @override
  _DogRegister2State createState() => _DogRegister2State();
}

class _DogRegister2State extends State<DogRegister2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 283),
                _buildInputField(hintText: '반려견 상태 선택'),
                const SizedBox(height: 21),
                _buildInputFieldWithSuffix(hintText: '나이', suffix: '세'),
                const SizedBox(height: 21),
                _buildInputField(hintText: '혈액형'),
                const SizedBox(height: 21),
                _buildInputField(hintText: '반려견 상태 선택'),
              ],
            ),
          ),
          Positioned(
            top: 108,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 127.57,
                      height: 127.57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        color: const Color(0xFFFBF8F8),
                        border: Border.all(
                          color: const Color(0xE0E2E2E2),
                          width: 1.0,
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/img/dog.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          print('카메라 버튼 클릭됨');
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset('assets/img/camera.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 97,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  print('다음 화면으로 이동합니다');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFDC8B),
                  fixedSize: Size(194.68, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  '완료',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String hintText}) {
    return Container(
      width: 341,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFieldWithSuffix({
    required String hintText,
    required String suffix,
  }) {
    return Container(
      width: 341,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                suffix,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
          ),
        ),
      ),
    );
  }
}
