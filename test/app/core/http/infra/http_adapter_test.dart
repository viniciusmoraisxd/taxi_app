import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taxi_app/app/core/http/data/data.dart';
import 'package:taxi_app/app/core/http/infra/infra.dart';

import 'mocks/mocks.dart';

void main() {
  late HttpAdapter sut;
  late DioSpy dio;
  late Map<String, dynamic> body;
  late Map<String, dynamic> headers;
  late String path;

  setUp(() async {
    headers = {"content-type": "application/json"};
    dio = DioSpy(
        baseOptions:
            BaseOptions(baseUrl: faker.internet.httpsUrl(), headers: headers));
    sut = HttpAdapter(client: dio);
    body = {"any_key": "any_value"};
    path = "any_path";

    dio.mockPostRequest(statusCode: 200);
  });

  group("Post method", () {
    test('Should call post with correct values', () async {
      await sut.request(path: path, method: HttpMethods.post, body: body);

      verify(() => dio.post(path, data: body));
    });

    test('Should return data if post returns status code 200', () async {
      final response =
          await sut.request(path: path, method: HttpMethods.post, body: body);

      expect(response, "{'any_key': 'any_value'}");
    });

    test('Should return null if post returns status code 200 with no data',
        () async {
      dio.mockPostRequest(statusCode: 200, data: "");

      final response =
          await sut.request(path: path, method: HttpMethods.post, body: body);

      expect(response, null);
    });

    test('Should throw badRequestError if post returns status code 400',
        () async {
      dio.mockPostRequestError(statusCode: 400);
      final response =
          sut.request(path: path, method: HttpMethods.post, body: body);

      expect(response, throwsA(HttpError.badRequest));
    });

    test('Should throw unauthorizedError if post returns status code 401',
        () async {
      dio.mockPostRequestError(statusCode: 401);
      final response =
          sut.request(path: path, method: HttpMethods.post, body: body);

      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should throw forbiddenError if post returns status code 403',
        () async {
      dio.mockPostRequestError(statusCode: 403);
      final response =
          sut.request(path: path, method: HttpMethods.post, body: body);

      expect(response, throwsA(HttpError.forbidden));
    });

    test('Should throw notFound if post returns status code 404', () async {
      dio.mockPostRequestError(statusCode: 404);
      final response =
          sut.request(path: path, method: HttpMethods.post, body: body);

      expect(response, throwsA(HttpError.notFound));
    });

    test(
        'Should throw serverError if post returns status code 500 or other not listed',
        () async {
      dio.mockPostRequestError(statusCode: 500);
      final response =
          sut.request(path: path, method: HttpMethods.post, body: body);

      expect(response, throwsA(HttpError.serverError));
    });
  });

  group('get', () {
    test('Should call get with correct values', () async {
      await sut.request(path: path, method: HttpMethods.get, body: body);
      verify(() => dio.get(path, queryParameters: body));
    });

    test('Should return data if post returns status code 200', () async {
      final response =
          await sut.request(path: path, method: HttpMethods.get, body: body);

      expect(response, "{'any_key': 'any_value'}");
    });

    test('Should return null if post returns status code 200 with no data',
        () async {
      dio.mockGetRequest(statusCode: 200, data: "");

      final response =
          await sut.request(path: path, method: HttpMethods.get, body: body);

      expect(response, null);
    });

    test('Should throw badRequestError if post returns status code 400',
        () async {
      dio.mockGetRequestError(statusCode: 400);
      final response =
          sut.request(path: path, method: HttpMethods.get, body: body);

      expect(response, throwsA(HttpError.badRequest));
    });

    test('Should throw unauthorizedError if post returns status code 401',
        () async {
      dio.mockGetRequestError(statusCode: 401);
      final response =
          sut.request(path: path, method: HttpMethods.get, body: body);

      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should throw forbiddenError if post returns status code 403',
        () async {
      dio.mockGetRequestError(statusCode: 403);
      final response =
          sut.request(path: path, method: HttpMethods.get, body: body);

      expect(response, throwsA(HttpError.forbidden));
    });

    test('Should throw notFound if post returns status code 404', () async {
      dio.mockGetRequestError(statusCode: 404);
      final response =
          sut.request(path: path, method: HttpMethods.get, body: body);

      expect(response, throwsA(HttpError.notFound));
    });

    test(
        'Should throw serverError if post returns status code 500 or other not listed',
        () async {
      dio.mockGetRequestError(statusCode: 500);
      final response =
          sut.request(path: path, method: HttpMethods.get, body: body);

      expect(response, throwsA(HttpError.serverError));
    });
  });
}
