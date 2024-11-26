import 'dart:io';
import 'package:dimple/common/component/custom_text_formfield.dart';
import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModifyPetInfoScreen extends StatefulWidget {
  const ModifyPetInfoScreen({super.key});

  @override
  State<ModifyPetInfoScreen> createState() => _ModifyPetInfoScreenState();
}

class _ModifyPetInfoScreenState extends State<ModifyPetInfoScreen> {
  XFile? selectedImage;
  String realDogType = '';
  String neutral1 = '';

  @override
  Widget build(BuildContext context) {
    final imagePicker = ImagePicker();
    return DefaultLayout(
      appBar: AppBar(
        title: Text(
          '반려견 정보 수정',
          style: TextStyle(
            fontSize: 18,
          ),
        ),

        centerTitle: true,
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
                onPressed: () {
                  // 정보 수정하는 api 연동 부분
                },
                child: Text('수정'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(35, 35),
                  backgroundColor: PRIMARY_COLOR,
                )),
          ),
        ],
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      selectedImage = image;
                    });
                  }
                },
                child: Stack(children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: selectedImage != null
                        ? FileImage(File(selectedImage!.path))
                        : const AssetImage('assets/img/runningDog.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white, // Icon color
                        size: 15, // Icon size
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 14.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFormField(onChanged: (value) {}, labelText: '이름'),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CustomTextFormField(
                    onChanged: (value) {},
                    labelText: '나이',
                    isNumber: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 14.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFormField(
                    onChanged: (value) {},
                    labelText: '몸무게',
                    isNumber: true,
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CustomTextFormField(
                    onChanged: (value) {},
                    labelText: '신장(cm)',
                    isNumber: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 14.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFormField(onChanged: (value) {}, labelText: '혈액형'),
                  const SizedBox(
                    width: 12.0,
                  ),
                  bloodTypeDropDown(),
                ],
              ),
              const SizedBox(
                height: 14.0,
              ),
              dogTypeDropDown(),
              const SizedBox(
                height: 14.0,
              ),
              CustomTextFormField(
                onChanged: (value) {},
                labelText: '등록번호',
                isNumber: true,
                size: 320,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bloodTypeDropDown() {
    List<String> neutral = ['O', 'X'];
    if (neutral1 == '') {
      neutral1 = neutral.first;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '중성화',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          width: 120,
          height: 50,
          child: DropdownButton(
              isExpanded: true,
              value: neutral1,
              items: neutral.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                neutral1 = value!;
              }),
        ),
      ],
    );
  }

  Widget dogTypeDropDown() {
    List<String> dogType = ['포메라니안', '푸들', '허스키'];
    if (realDogType == '') {
      realDogType = dogType.first;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '품종',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          width: 320,
          height: 50,
          child: DropdownButton(
              isExpanded: true,
              value: realDogType,
              items: dogType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                realDogType = value!;
              }),
        ),
      ],
    );
  }
}
