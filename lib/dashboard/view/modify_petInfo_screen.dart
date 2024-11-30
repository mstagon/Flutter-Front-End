import 'dart:io';
import 'package:dimple/common/component/custom_dropdown_form_field.dart';
import 'package:dimple/common/component/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';

class ModifyPetInfoScreen extends StatefulWidget {
  const ModifyPetInfoScreen({super.key});

  @override
  State<ModifyPetInfoScreen> createState() => _ModifyPetInfoScreenState();
}

class _ModifyPetInfoScreenState extends State<ModifyPetInfoScreen> {
  XFile? selectedImage;
  String realDogType = '';
  String neutral1 = '';
  String gender = '';
  String blood = '';

  final List<String> bloodTypes = ['IDA1', 'IDA2', 'IDA3', 'IDA4'];
  final List<String> genderTypes = ['암컷', '수컷'];
  final List<String> neutralTypes = ['O', 'X'];
  final List<String> dogTypes = [
    '포메라니안', '푸들', '허스키', '말티즈', '시츄', '불독', '치와와', '골든리트리버','포메라니안', '푸들', '허스키', '말티즈', '시츄', '불독', '치와와', '골든리트리버','포메라니안', '푸들', '허스키', '말티즈', '시츄', '불독', '치와와', '골든리트리버','포메라니안', '푸들', '허스키', '말티즈', '시츄', '불독', '치와와', '골든리트리버'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('반려견 정보 수정'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              onPressed: () {
                // 정보 수정하는 API 연동 부분
              },
              child: const Text('수정',),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                minimumSize: Size(35, 35),
                backgroundColor: PRIMARY_COLOR,
                padding: EdgeInsets.symmetric(horizontal: 16.0)
              ),
            ),
          ),
        ],
      ),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
              const SizedBox(height: 10.0),
              _buildImagePicker(),
              const SizedBox(height: 10.0),
              _buildBasicInfoRow(),
              const SizedBox(height: 10.0),
              _buildMeasurementRow(),
              const SizedBox(height: 10.0),
              _buildAdditionalInfoRow(),
              const SizedBox(height: 10.0),
            ],
          ),
    );
  }

  Widget _buildImagePicker() {
    final imagePicker = ImagePicker();
    return GestureDetector(
      onTap: () async {
        final image = await imagePicker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            selectedImage = image;
          });
        }
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: selectedImage != null
                  ? FileImage(File(selectedImage!.path))
                  : const AssetImage('assets/img/runningDog.jpg') as ImageProvider,
            ),
          ),
          Positioned(
            left: 65,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextFormField(labelText: '이름'),
        CustomTextFormField(labelText: '나이', isNumber: true),
      ],
    );
  }

  Widget _buildMeasurementRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextFormField(labelText: '몸무게(kg)'),
        CustomTextFormField(labelText: '신장(cm)', isNumber: true),
      ],
    );
  }

  Widget _buildAdditionalInfoRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropdownFormField(
              title: '혈액형',
              selectedValue: blood,
              options: bloodTypes,
              onChanged: (String value) {
                setState(() {
                  blood = value;
                });
              },
              hintText: '혈액형',
            ),
            CustomTextFormField(labelText: '다리길이(cm)'),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropdownFormField(
              title: '성별',
              selectedValue: gender,
              options: genderTypes,
              onChanged: (String value) {
                setState(() {
                  gender = value;
                });
              },
              hintText: '성별',
            ),
            CustomDropdownFormField(
              title: '중성화',
              selectedValue: neutral1,
              options: neutralTypes,
              onChanged: (String value) {
                setState(() {
                  neutral1 = value;
                });
              },
              hintText: '중성화',
            ),
          ],
        ),
        const SizedBox(height: 14),
        CustomDropdownFormField(
          title: '품종',
          selectedValue: realDogType,
          options: dogTypes,
          width: 310,
          onChanged: (String value) {
            setState(() {
              realDogType = value;
            });
          },
          hintText: '품종',
        ),
        const SizedBox(height: 14),
        const CustomTextFormField(
          labelText: '등록번호',
          isNumber: true,
          width: 310,
        ),
      ],
    );
  }
}