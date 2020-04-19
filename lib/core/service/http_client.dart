import 'package:dio/dio.dart';
import 'package:flutterboilerplate/core/service/interceptor.dart';

class HttpClient {
  Map<String, String> headers;
  final client = Dio();
  factory HttpClient() => HttpClient();

  HttpClient.internal(this.headers) {
    client.interceptors.add(HttpInterceptor(client));
  }

  static final instance = HttpClient.internal({});
}
