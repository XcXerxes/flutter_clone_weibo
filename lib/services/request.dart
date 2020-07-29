/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-07-25 16:55:15
 * @LastEditors: leo
 * @LastEditTime: 2020-07-25 17:44:26
 */
import 'package:dio/dio.dart';
import 'package:flutter_wb_clone/helpers/constant.dart';

class DioManager {
  Dio dio = Dio();

  DioManager() {
    dio.options.baseUrl = Constant.baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.contentType = Headers.formUrlEncodedContentType;
    dio.interceptors.add(LogInterceptor(requestBody: true)); // 是否开启请求日志
  }

  /// get请求
  Future get(String url, dynamic params) async {
    Response res = await _requestHttp(url, params: params);
    return res;
  }

  /// post请求
  Future post(String url, dynamic params) async {
    Response res = await _requestHttp(url, params: params, method: 'post');
    return res;
  }

  /// 请求的http
  Future<Response> _requestHttp(String url,
      {String method = 'get', dynamic params}) async {
    Response response;
    try {
      if (method == 'get') {
        if (params != null) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
      return response;
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: 201);
      }

      /// debug模式才打印
      if (Constant.ISDEBUG) {
        print('请求异常：${e.toString()}');
      }
      return errorResponse;
    }
  }
}
