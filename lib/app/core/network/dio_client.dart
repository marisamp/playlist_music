import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:playlist_music/app/core/constant.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: AppConstant.baseUrl,
        connectTimeout: const Duration(milliseconds: 30000), // 30 วิ
        receiveTimeout: const Duration(milliseconds: 30000),
        contentType: 'application/json',
      ));

      if (kDebugMode) {
        _dio!.interceptors.add(LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        ));
      }
      _dio!.interceptors.add(
        InterceptorsWrapper(
          onError: (DioException e, handler) {  
            _handleDioError(e);
            return handler.next(e); 
          },
        ),
      );
    
    }
    return _dio!;
  }

  static void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        log("Timeout Error: Server ตอบสนองช้า");
        break;
      case DioExceptionType.badResponse:
        log("Server Error: ${e.response?.statusCode}");
        break;
      case DioExceptionType.connectionError:
        log("Network Error: ไม่ได้เชื่อมต่ออินเทอร์เน็ต");
        break;
      default:
        log("Unknown Error: ${e.message}");
    }
  }
}
