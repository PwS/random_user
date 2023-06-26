import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:randomuser/service/config/dio_interceptor.dart';

class DioClient {
  late Dio _dio;

  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  ///Optional Argument
  ///
  ///UnitTest Default is False , Unused For Now
  ///
  ///Headers if needed for customize
  ///
  ///onlyAliceInterceptor if false then the record for alice is not registered
  ///
  ///Default For receiveTimeOut & connectTimeout is 11.67 Minutes or 700 Seconds
  DioClient(
      {bool isUnitTest = false,
      Map<String, dynamic>? headers,
      int receiveTimeOut = 1,
      int connectTimeout = 1,
      bool? receiveDataWhenStatusError,
      String baseUrl = ''}) {
    _dio = Dio(
      BaseOptions(
        headers: headers ??
            {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
        receiveTimeout: Duration(minutes: receiveTimeOut),
        baseUrl: baseUrl,
        connectTimeout: Duration(minutes: connectTimeout),
        receiveDataWhenStatusError: receiveDataWhenStatusError,
        validateStatus: (int? status) {
          return status! > 0;
        },
      ),
    );
    _dio.interceptors.add(DioInterceptor());
  }

  Future<Response> getRequest(String url,
      {Map<String, dynamic>? queryParameters,
      bool withToken = true,
      String? customToken,
      Options? options}) async {
    Response result;
    try {
      result = await _dio.get(url,
          queryParameters: queryParameters, options: options);
      return result;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameter,
      bool withToken = true,
      String? customToken}) async {
    Response result;
    try {
      result =
          await _dio.post(url, queryParameters: queryParameter, data: data);
      return result;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
