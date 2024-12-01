import 'package:dimple/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class AddNewPetScreen extends StatelessWidget {
  const AddNewPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(child: Center(child: Text('반려견 추가 페이지'),));
  }
}
