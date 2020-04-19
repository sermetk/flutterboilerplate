import 'package:dio/dio.dart';
class HttpInterceptor extends InterceptorsWrapper { //Ref: https://github.com/flutterchina/dio/blob/master/example/interceptor_lock.dart
  Dio currentClient;
  Dio refreshClient = new Dio();

  HttpInterceptor(this.currentClient);

  @override
  Future onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) async {
    print(error);    
    if (error.response?.statusCode == 401) { //Assume 401 stands for token expired
      RequestOptions options = error.response.request;
      currentClient.lock();
      currentClient.interceptors.responseLock.lock();
      currentClient.interceptors.errorLock.lock();

      //Refresh token

      currentClient.unlock();
      currentClient.interceptors.responseLock.unlock();
      currentClient.interceptors.errorLock.unlock();
      return currentClient.request(options.path, options: options); //Recall
    }
    return super.onError(error);
  }
}