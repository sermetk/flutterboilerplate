import 'package:dio/dio.dart';
import 'package:flutterboilerplate/core/service/interceptor.dart';

class HttpClient {
  Map<String, String> headers;
  String baseUrl;
  final client = Dio();
  Dio tokenClient = new Dio();

  factory HttpClient() => HttpClient();

  HttpClient.internal(this.headers) {
    client.interceptors.add(HttpInterceptor(client));
  }

  static final instance = HttpClient.internal({});
}
