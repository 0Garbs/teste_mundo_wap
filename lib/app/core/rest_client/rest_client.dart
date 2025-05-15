abstract interface class RestClient {
  Future<dynamic> postRequest({required String uri, Object? data});
}
