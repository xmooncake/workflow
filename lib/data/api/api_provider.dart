import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import 'package:rfid77workflow/config/constants.dart';
import 'package:rfid77workflow/data/api/retry_interceptor.dart';

/// A class that provides API functionality for the application.
class ApiProvider {
  ApiProvider._(this._dio);

  static ApiProvider? _instance;
  final Dio _dio;

  /// Returns an instance of [ApiProvider].
  ///
  /// If the instance is not already created, it creates a new instance and initializes it with the access token.
  /// The access token is obtained from the [RegisterAppService] class.
  /// The [dio] instance is configured with the base URL and query parameters.
  /// The [BackgroundTransformer] is set as the transformer for the [dio] instance.
  static Future<ApiProvider> instance({String? testingAcessToken}) async {
    if (_instance == null) {
      const String accessToken = kApiToken;
      const String baseUrl = kApiBaseUrl;

      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          queryParameters: {
            'api_token': accessToken,
          },
        ),
      );

      dio.transformer = BackgroundTransformer()
        ..jsonDecodeCallback = _parseJson;

      dio.interceptors.add(RetryInterceptor(dio: dio));

      _instance = ApiProvider._(
        dio,
      );
    }
    return _instance!;
  }

  static Map<String, dynamic> _parseAndDecode(String response) {
    return jsonDecode(response) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> _parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  Future<Response> fetchUsers() async => _dio.get('/users');

  Future<Response> fetchContrahents() async => _dio.get('/contrahents');

  Future<Response> postEvaluations({required Object evaluationsJson}) async =>
      _dio.post(
        '/evaluations',
        data: evaluationsJson,
      );
}
