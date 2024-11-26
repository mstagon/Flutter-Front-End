import 'package:flutter/material.dart';
import 'dog_register2.dart';

class DogRegister1 extends StatefulWidget {
  @override
  _DogRegister1State createState() => _DogRegister1State();
}

class _DogRegister1State extends State<DogRegister1> {
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
                _buildInputField(hintText: '이름'),
                const SizedBox(height: 21),
                _buildInputFieldWithSuffix(hintText: '나이', suffix: '세'),
                const SizedBox(height: 21),
                _buildInputFieldWithSuffix(hintText: '몸무게', suffix: 'kg'),
                const SizedBox(height: 21),
                _buildInputField(hintText: '등록번호'),
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
                          image: AssetImage('assets/img/banreou.png'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DogRegister2(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFDC8B),
                  fixedSize: Size(194.68, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  '다음',
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
