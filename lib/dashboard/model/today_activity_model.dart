import 'package:json_annotation/json_annotation.dart';

part 'today_activity_model.g.dart';

@JsonSerializable()
// 오늘의 활동 데이터 조회
class TodayActivityModel{
  final int steps;
  final double distance;
  final double calories;

  TodayActivityModel({
    required this.steps,
    required this.distance,
    required this.calories,
});
  factory TodayActivityModel.fromJson(Map<String,dynamic> json)
  => _$TodayActivityModelFromJson(json);
}