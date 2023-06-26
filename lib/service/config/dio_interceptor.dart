import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = '';
    options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    if (options.data is! FormData) {
      try {
        options.queryParameters.forEach(
          (k, v) => debugPrint(
            '► $k: $v',
          ),
        );
      } catch (_) {}
      try {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final String prettyJson = encoder.convert(options.data);
        log(
          "REQUEST ► ︎ ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}\n\n"
          'Headers:\n'
          '$headerMessage\n'
          '❖ QueryParameters : \n'
          'Body: $prettyJson',
        );
      } catch (_) {}
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(
      "<-- ${err.message} ${err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL'}\n\n"
      "${err.response != null ? err.response!.data : 'Unknown Error'}",
    );

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = '';
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);

    log(
      '◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}\n\n'
      'Headers:\n'
      '$headerMessage\n'
      '❖ Results : \n'
      'Response: $prettyJson',
    );
    super.onResponse(response, handler);
  }
}
