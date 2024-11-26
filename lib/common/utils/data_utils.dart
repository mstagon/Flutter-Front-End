import 'package:dimple/common/const/const.dart';

class DataUtils{
  static DateTime stringToDateTime(String value){
    return DateTime.parse(value);
  }

  static String pathToUrl(String value){
    return 'http://$ip/$value';
  }
}