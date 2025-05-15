import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'rest_client.dart';

class RestClientImpl extends DioForNative implements RestClient {
  RestClientImpl({required String baseUrl})
      : super(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 60000),
        )) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
    options.headers['content-Type'] = 'application/json';
  }

  @override
  Future<dynamic> postRequest({
    required String uri,
    Object? data,
  }) async {
    return await unauth().post(uri, data: data);
  }

  RestClientImpl auth() {
    //? Autenticar a requisição
    // options.headers['authorization'] =
    //     'Bearer ${OpenIdAuthenticator.i.accessToken}';
    return this;
  }

  RestClientImpl unauth() {
    return this;
  }
}
