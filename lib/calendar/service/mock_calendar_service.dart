import 'dart:collection';
import '../model/calendar_event.dart';

class MockCalendarService {
  final Map<DateTime, List<CalendarEvent>> _eventStorage = {};

  MockCalendarService() {
    _initializeDummyData();
  }

  void _initializeDummyData() {
    final now = DateTime.now();
    final events = [
      CalendarEvent(
        id: '1',
        date: DateTime(now.year, now.month, 10),
        type: EventType.vaccination,
        description: '코로나 예방접종',
        count: 1,
      ),
      CalendarEvent(
        id: '2',
        date: DateTime(now.year, now.month, 15),
        type: EventType.hospital,
        description: '정기 검진',
      ),
      CalendarEvent(
        id: '3',
        date: DateTime(now.year, now.month, 5),
        type: EventType.period,
        description: '월경 예정일',
      ),
    ];

    for (var event in events) {
      _addEventToStorage(event);
    }
  }

  void _addEventToStorage(CalendarEvent event) {
    final date = DateTime(event.date.year, event.date.month, event.date.day);
    if (!_eventStorage.containsKey(date)) {
      _eventStorage[date] = [];
    }
    _eventStorage[date]!.add(event);
  }

  Future<List<CalendarEvent>> getMonthEvents(int year, int month) async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<CalendarEvent> monthEvents = [];
    _eventStorage.forEach((date, events) {
      if (date.year == year && date.month == month) {
        monthEvents.addAll(events);
      }
    });
    return monthEvents;
  }

  Future<void> addEvent(CalendarEvent event) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newEvent = CalendarEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: event.date,
      type: event.type,
      description: event.description,
      count: event.count,
    );
    _addEventToStorage(newEvent);
  }

  Future<void> deleteEvent(CalendarEvent event) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final date = DateTime(event.date.year, event.date.month, event.date.day);
    _eventStorage[date]?.removeWhere((e) => e.id == event.id);
  }
} 