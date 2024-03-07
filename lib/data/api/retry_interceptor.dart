import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

/// Interceptor that handles retrying failed Dio requests.
///
/// This interceptor is responsible for retrying failed Dio requests up to a maximum number of retries.
/// It delays each retry attempt by an increasing amount of time based on the `baseDelay` property.
/// The maximum number of retries is determined by the `maxRetries` property.
///
/// Example usage:
/// ```dart
/// final dio = Dio();
/// dio.interceptors.add(RetryInterceptor(
///   dio: dio,
///   maxRetries: 5,
///   baseDelay: 1,
/// ));
/// ```
class RetryInterceptor extends Interceptor {
  /// Creates a new instance of [RetryInterceptor].
  ///
  /// The [dio] parameter is the Dio instance to be used for making the retry requests.
  /// The [maxRetries] parameter specifies the maximum number of retries allowed.
  /// The [baseDelay] parameter specifies the base delay in seconds for each retry attempt.
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 5,
    this.baseDelay = 1,
  });

  final Dio dio;
  final int maxRetries;
  final int baseDelay;

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final int retryCount = err.requestOptions.extra['retries'] as int? ?? 0;

    if (retryCount < maxRetries) {
      log('Attempt to retry for ${err.requestOptions.path}. Retry $retryCount/$maxRetries.');

      err.requestOptions.extra['retries'] = retryCount + 1;

      final int increasingDelay = baseDelay * retryCount;

      await Future.delayed(Duration(seconds: increasingDelay));

      try {
        return dio.fetch(err.requestOptions).then(
              (res) => handler.resolve(res),
              onError: (e) => handler.reject(e as DioException),
            );
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }
}
