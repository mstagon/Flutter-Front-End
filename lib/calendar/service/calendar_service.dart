import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/calendar_event.dart';

part 'calendar_service.g.dart';

@RestApi()
abstract class CalendarService {
  factory CalendarService(Dio dio) = _CalendarService;

  @GET('/api/calendar/events')
  Future<List<CalendarEvent>> getMonthEvents(
    @Query('year') int year,
    @Query('month') int month,
  );

  @POST('/api/calendar/events')
  Future<void> addEvent(@Body() CalendarEvent event);

  @DELETE('/api/calendar/events/{id}')
  Future<void> deleteEvent(@Path('id') String id);
} 