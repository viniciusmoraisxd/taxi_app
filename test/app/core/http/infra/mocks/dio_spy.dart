import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioSpy extends Mock implements Dio {
  final BaseOptions baseOptions;

  DioSpy({required this.baseOptions}){
    mockPostRequest(statusCode: 200);
    mockGetRequest(statusCode: 200);
  }

  When mockPostCall() => when(() => post(any(), data: any(named: "data")));

  void mockPostRequest(
          {String data = "{'any_key': 'any_value'}",
          required int statusCode}) =>
      mockPostCall().thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: "any_path"),
          data: data,
          statusCode: statusCode));

  void mockPostRequestError({required int statusCode}) =>
      mockPostCall().thenThrow(
        DioError(
          requestOptions: RequestOptions(path: "any_path"),
          response: Response(
              requestOptions: RequestOptions(path: "any_path"),
              statusCode: statusCode),
        ),
      );

  When mockGetCall() =>
      when(() => get(any(), queryParameters: any(named: "queryParameters")));

  void mockGetRequest(
          {String data = "{'any_key': 'any_value'}",
          required int statusCode}) =>
      mockGetCall().thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: "any_path"),
          data: data,
          statusCode: statusCode));

  void mockGetRequestError({required int statusCode}) =>
      mockGetCall().thenThrow(
        DioError(
          requestOptions: RequestOptions(path: "any_path"),
          response: Response(
              requestOptions: RequestOptions(path: "any_path"),
              statusCode: statusCode),
        ),
      );
}
