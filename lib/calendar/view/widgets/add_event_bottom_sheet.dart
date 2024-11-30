import 'package:flutter/material.dart';
import '../../model/calendar_event.dart';

class AddEventBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final Function(CalendarEvent) onEventAdded;

  const AddEventBottomSheet({
    Key? key,
    required this.selectedDate,
    required this.onEventAdded,
  }) : super(key: key);

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  late EventType selectedType;
  final descriptionController = TextEditingController();
  final countController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedType = EventType.hospital;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.selectedDate.month}월 ${widget.selectedDate.day}일 일정 추가',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildEventTypeSelector(),
          const SizedBox(height: 16),
          _buildDescriptionField(),
          if (selectedType == EventType.vaccination) ...[
            const SizedBox(height: 16),
            _buildCountField(),
          ],
          const SizedBox(height: 24),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildEventTypeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EventType>(
          value: selectedType,
          isExpanded: true,
          items: EventType.values.map((type) {
            String label;
            Color chipColor;
            
            switch (type) {
              case EventType.vaccination:
                label = '예방접종';
                chipColor = Colors.pink.shade100;
                break;
              case EventType.hospital:
                label = '병원내원';
                chipColor = Colors.blue.shade100;
                break;
              case EventType.period:
                label = '월경';
                chipColor = Colors.red.shade100;
                break;
              case EventType.fertile:
                label = '가임기';
                chipColor = Colors.purple.shade100;
                break;
            }

            return DropdownMenuItem(
              value: type,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: chipColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(label),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedType = value!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: descriptionController,
      decoration: InputDecoration(
        labelText: '설명',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: 2,
    );
  }

  Widget _buildCountField() {
    return TextField(
      controller: countController,
      decoration: InputDecoration(
        labelText: '회차',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('취소'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              final event = CalendarEvent(
                date: widget.selectedDate,
                type: selectedType,
                description: descriptionController.text.isEmpty 
                    ? null 
                    : descriptionController.text,
                count: countController.text.isEmpty 
                    ? null 
                    : int.parse(countController.text),
              );
              widget.onEventAdded(event);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber.shade200,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('저장'),
          ),
        ),
      ],
    );
  }
} 