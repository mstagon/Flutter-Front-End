import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String title;
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final double width;
  final double height;
  final String hintText;
  const CustomDropdownFormField({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.width = 135,
    this.height = 50,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title.isNotEmpty)
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: () => _showCustomBottomSheet(context),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFF3F2F2),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedValue.isEmpty ? hintText : selectedValue,
                  style: TextStyle(
                    color: selectedValue.isEmpty ? Colors.grey : Colors.black,
                    fontSize: 16.0
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          controller: ModalScrollController.of(context),
          physics: const ClampingScrollPhysics(),
          children: ListTile.divideTiles(
              context: context,
              tiles: List.generate(
                options.length,
                (index) => ListTile(
                    title: Text(options[index]),
                    onTap: () {
                      onChanged(options[index]);

                      Navigator.of(context).pop();
                    }),
              )).toList(),
        );
      },
    );
  }
}
