import 'package:dio/dio.dart';

import '../data/data.dart';

class HttpAdapter implements HttpClient {
  final Dio client;

  HttpAdapter({required this.client});

  @override
  Future<dynamic> request({
    required String path,
    required HttpMethods method,
    Map<String, dynamic>? body,

  }) async {
    late Response response;

    try {
      switch (method) {
        case HttpMethods.post:
          response = await client.post(path, data: body);
          break;
        case HttpMethods.get:
          response = await client.get(path,
              queryParameters: body);
          break;
        case HttpMethods.put:
          response = await client.put(path, data: body);
          break;
        case HttpMethods.delete:
          response = await client.delete(path, data: body);
          break;
      }

      return _handleSuccessResponse(response);
    } on DioError catch (e) {
      _handleErrorResponse(e.response);
    }
  }

  dynamic _handleSuccessResponse(Response response) {
    final responseData = response.data;

    return response.statusCode == 200
        ? (responseData.isEmpty ? null : responseData)
        : null;
  }

  _handleErrorResponse(Response? response) {
    final statusCode = response?.statusCode;

    switch (statusCode) {
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
