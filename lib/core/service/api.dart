import 'package:dio/dio.dart' as dio;
import 'package:flutterboilerplate/core/service/http_client.dart';
import 'package:flutterboilerplate/core/service/json_mapper.dart';
import 'package:flutterboilerplate/core/service/service_result.dart';

class ApiBuilder {
final String baseUrl="jsonplaceholder.typicode.com";

  Future<ServiceResult<T, K>> getAsync<T, K>(String endPoint,
      [Map<String, String> queryParameters]) async {
    var uri = Uri.https(baseUrl, endPoint, queryParameters);
    dio.Response<dynamic> response = await HttpClient.instance.client
        .getUri(uri,
            options: dio.Options(headers: HttpClient.instance.headers));

    return generateResultFromResponse<T, K>(response);
  }

  Future<ServiceResult<T, K>> postAsync<T, K>(
      String endPoint, dynamic postedData,
      [Map<String, String> queryParameters]) async {
    var uri = Uri.https(baseUrl, endPoint, queryParameters);

    dio.Response<dynamic> response = await HttpClient.instance.client
        .postUri(uri,
            options: dio.Options(headers: HttpClient.instance.headers),
            data: postedData);

    return generateResultFromResponse<T, K>(response);
  }

  Future<ServiceResult<T, K>> putAsync<T, K>(
      {String endPoint,
      dynamic postedData,
      Map<String, String> queryParameters}) async {
    var uri = Uri.https(baseUrl, endPoint, queryParameters);

    dio.Response<dynamic> response = await HttpClient.instance.client
        .putUri(uri,
            options: dio.Options(headers: HttpClient.instance.headers),
            data: postedData);

    return generateResultFromResponse<T, K>(response);
  }

  Future<ServiceResult<T, K>> deleteAsync<T, K>(String endPoint,
      [Map<String, String> queryParameters]) async {
    var uri = Uri.https(baseUrl, endPoint, queryParameters);

    dio.Response<dynamic> response = await HttpClient.instance.client
        .deleteUri(uri,
            options: dio.Options(headers: HttpClient.instance.headers));

    return generateResultFromResponse<T, K>(response);
  }

  Future<ServiceResult<T, K>> generateResultFromResponse<T, K>(
      dio.Response<dynamic> response) async { 
    if (response.statusCode == 200) {
     return ServiceResult<T, K>(
              success: true, data: JsonMapper.fromJson<T, K>(response.data));
    } else if (response.statusCode == 401) {
      return null; //Refresh token and recall
    } else {
      return null; //throw exception and write log.
    }
  }
}
