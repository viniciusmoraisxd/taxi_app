
import 'http_methods.dart';

abstract class HttpClient {
  Future<dynamic> request({
    required String path,
    required HttpMethods method,
    Map<String, dynamic>? body,
  });
}