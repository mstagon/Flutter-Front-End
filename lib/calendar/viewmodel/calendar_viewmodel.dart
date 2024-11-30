import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/calendar_event.dart';
import '../repository/calendar_repository.dart';

class CalendarViewModel extends StateNotifier<AsyncValue<List<CalendarEvent>>> {
  final CalendarRepository _repository;
  DateTime _focusedDay = DateTime.now();
  
  CalendarViewModel(this._repository) : super(const AsyncValue.loading()) {
    loadMonthEvents(_focusedDay.year, _focusedDay.month);
  }

  DateTime get focusedDay => _focusedDay;

  void updateFocusedDay(DateTime day) {
    if (day.month != _focusedDay.month) {
      _focusedDay = day;
      loadMonthEvents(day.year, day.month);
    }
  }

  Future<void> loadMonthEvents(int year, int month) async {
    state = const AsyncValue.loading();
    try {
      final events = await _repository.getMonthEvents(year, month);
      state = AsyncValue.data(events);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addEvent(CalendarEvent event) async {
    try {
      await _repository.addEvent(event);
      await loadMonthEvents(_focusedDay.year, _focusedDay.month);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteEvent(CalendarEvent event) async {
    try {
      await _repository.deleteEvent(event);
      await loadMonthEvents(_focusedDay.year, _focusedDay.month);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
} 