import '../model/calendar_event.dart';
import '../service/calendar_service.dart';
import '../service/mock_calendar_service.dart';

abstract class CalendarRepository {
  Future<List<CalendarEvent>> getMonthEvents(int year, int month);
  Future<void> addEvent(CalendarEvent event);
  Future<void> deleteEvent(CalendarEvent event);
}

class RealCalendarRepository implements CalendarRepository {
  final CalendarService _service;

  RealCalendarRepository(this._service);

  @override
  Future<List<CalendarEvent>> getMonthEvents(int year, int month) {
    return _service.getMonthEvents(year, month);
  }

  @override
  Future<void> addEvent(CalendarEvent event) {
    return _service.addEvent(event);
  }

  @override
  Future<void> deleteEvent(CalendarEvent event) {
    return _service.deleteEvent(event.id!);
  }
}

class MockCalendarRepository implements CalendarRepository {
  final MockCalendarService _service;

  MockCalendarRepository(this._service);

  @override
  Future<List<CalendarEvent>> getMonthEvents(int year, int month) {
    return _service.getMonthEvents(year, month);
  }

  @override
  Future<void> addEvent(CalendarEvent event) {
    return _service.addEvent(event);
  }

  @override
  Future<void> deleteEvent(CalendarEvent event) {
    return _service.deleteEvent(event);
  }
} 