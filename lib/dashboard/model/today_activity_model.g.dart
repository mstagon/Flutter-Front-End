// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayActivityModel _$TodayActivityModelFromJson(Map<String, dynamic> json) =>
    TodayActivityModel(
      steps: (json['steps'] as num).toInt(),
      distance: (json['distance'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
    );

Map<String, dynamic> _$TodayActivityModelToJson(TodayActivityModel instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'distance': instance.distance,
      'calories': instance.calories,
    };
