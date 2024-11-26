// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetInfoModel _$PetInfoModelFromJson(Map<String, dynamic> json) => PetInfoModel(
      name: json['name'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      breed: json['breed'] as String,
      thumbUrl: DataUtils.pathToUrl(json['thumbUrl'] as String),
      lastInjection:
          DataUtils.stringToDateTime(json['lastInjection'] as String),
    );

Map<String, dynamic> _$PetInfoModelToJson(PetInfoModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'name': instance.name,
      'age': instance.age,
      'weight': instance.weight,
      'breed': instance.breed,
      'thumbUrl': instance.thumbUrl,
      'lastInjection': instance.lastInjection.toIso8601String(),
    };
