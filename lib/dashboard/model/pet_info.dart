// import 'package:json_annotation/json_annotation.dart';
// import 'package:livingalone/common/utils/data_utils.dart';
//
// part 'pet_info.g.dart';
//
// @JsonSerializable()
// class PetInfo {
//   final String name;
//   final int age;
//   final double weight;
//   final String breed;
//
//   @JsonKey(
//     fromJson: DataUtils.stringToDateTime,
//   )
//   final DateTime lastInjection;
//
//   PetInfo({
//     required this.name,
//     required this.age,
//     required this.weight,
//     required this.breed,
//     required this.lastInjection,
//   });
//
//   factory PetInfo.fromJson(Map<String,dynamic> json)
//   => _$PetInfoFromJson(json);
// }
