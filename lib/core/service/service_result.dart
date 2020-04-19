import 'package:flutterboilerplate/core/service/json_mapper.dart';

class ServiceResult<T, K> {
  dynamic data;
  bool success;
  String message;

  ServiceResult({this.data, this.success, this.message}) {
  }

  ServiceResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = JsonMapper.fromJson<T, K>(json['data']);
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
