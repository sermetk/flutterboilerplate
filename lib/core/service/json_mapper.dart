import 'package:flutterboilerplate/modules/users/user_entity.dart';

class JsonMapper {
  static T fromJson<T, K>(dynamic json) { // If T is a List, K is the subtype of the list.
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    } else if (T == UserEntity) {
      return UserEntity.fromJson(json) as T;
    } else if (T == bool ||
        T == String ||
        T == int ||
        T == double ||
        T == dynamic) {
      return json as T;
    } else {
      throw Exception(
          "Unknown class. Please add your class to generic fromJson method.");
    }
  }

  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) return null;
    List<K> output = List();
    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson<K, Null>(json));
    }
    return output;
  }
}
