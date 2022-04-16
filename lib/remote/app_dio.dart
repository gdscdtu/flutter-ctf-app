import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../foundation/constants.dart';

final dioProvider = Provider(create: (_) => AppDio.getInstance());

// ignore: prefer_mixin
class AppDio with DioMixin implements Dio {
  AppDio([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: Constants.of().endpoint,
      contentType: 'application/json',
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;

    interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      // options.headers.addAll(await userAgentClientHintsHeader());
      handler.next(options);
    }));

    if (kDebugMode) {
      // Local Log
      // interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
    if (kIsWeb) {
      httpClientAdapter = BrowserHttpClientAdapter();
    } else {
      httpClientAdapter = DefaultHttpClientAdapter();
    }
  }

  static Dio getInstance() => AppDio();
}
