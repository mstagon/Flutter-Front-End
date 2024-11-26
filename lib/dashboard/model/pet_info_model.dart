import 'package:dimple/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet_info_model.g.dart';

@JsonSerializable()
// 반려견 정보 모델
class PetInfoModel {
  final String gender;
  final String name;
  final int age;
  final double weight;
  final String breed;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;

  @JsonKey(
    fromJson: DataUtils.stringToDateTime,
  )
  final DateTime lastInjection;

  PetInfoModel({
    required this.name,
    required this.gender,
    required this.age,
    required this.weight,
    required this.breed,
    required this.thumbUrl,
    required this.lastInjection,
  });

  factory PetInfoModel.fromJson(Map<String,dynamic> json)
  => _$PetInfoModelFromJson(json);
}
