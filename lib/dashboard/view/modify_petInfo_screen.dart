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

  @override
  Widget build(BuildContext context) {
    final imagePicker = ImagePicker();
    return DefaultLayout(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0, // appbar가 앞으로 튀어나온거같은 효과를 준다.
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
                onPressed: () {},
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
              const SizedBox(height: 14.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFormField(onChanged: (value){}, labelText: '이름'),
                  const SizedBox(width: 12.0,),
                  CustomTextFormField(onChanged: (value){}, labelText: '나이', isNumber: true,),
                ],
              ),
              const SizedBox(height: 14.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFormField(onChanged: (value){}, labelText: '몸무게',isNumber: true,),
                  const SizedBox(width: 12.0,),
                  CustomTextFormField(onChanged: (value){}, labelText: '신장(cm)', isNumber: true,),
                ],
              ),
              const SizedBox(height: 14.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFormField(onChanged: (value){}, labelText: '혈액형'),
                  const SizedBox(width: 12.0,),
                  CustomTextFormField(onChanged: (value){}, labelText: '품종'),
                ],
              ),
              const SizedBox(height: 14.0,),
              CustomTextFormField(onChanged: (value){}, labelText: '등록번호',isNumber: true, size: 320,),
              const SizedBox(height: 14.0,),
              CustomTextFormField(onChanged: (value){}, labelText: '반려견 상태 (메모)', size: 320,),
            ],
          ),
        ),
      ),
    );
  }
}
