enum EventType {
  vaccination,
  hospital,
  period,
  fertile,
}

class CalendarEvent {
  final String? id;
  final DateTime date;
  final EventType type;
  final String? description;
  final int? count;
  
  CalendarEvent({
    this.id,
    required this.date,
    required this.type,
    this.description,
    this.count,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      date: DateTime.parse(json['date']),
      type: EventType.values.byName(json['type']),
      description: json['description'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type.name,
      'description': description,
      'count': count,
    };
  }
} 