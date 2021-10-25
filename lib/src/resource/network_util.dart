import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ss/src/resource/token.dart';

import 'invoice_api_proivder.dart';


InvoiceApiProvider apiProvider = InvoiceApiProvider();

class NetworkUtil {
  static Dio _dio = new Dio();
  static NetworkUtil _instance = NetworkUtil.internal();
  static String newToken = mainToken;

  factory NetworkUtil() => _instance;
  NetworkUtil.internal() {
    _dio.interceptors.clear();
    _dio.options.baseUrl = invoiceListUrl;
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers["Authorization"] = "Bearer " + newToken;
      options.headers["X-TenantId"] = "local";
      options.headers["Content-type"] = "application/json";
      return options;
    }, onResponse: (Response response) {
      return response; // continue
    }, onError: (DioError e) {
      print('error interceptor');
      if (e.response != null) {
        print(e.response);
        print("Грешка: ${e.response.data['status']}, "
            "${e.response.data['message']}, ${e.response.data['error']}");
      } else {
        print(e.message);
      }
      return e; //continue
    }));
  }

  Future<Response> get(String url) async {
    return await _dio.get(url);
  }

  Future<Response> post(String url, {required Options options, data}) async {

    print("DIO DATA PARTNER NAME " + data.example.counterParty.partnerName.toString());
    print("DIO DATA DOCUMENT DATE FROM  " + data.example.filterStartPartnerDocumentDate.toString());
    print("DIO DATA DOCUMENT DATE TO  " + data.example.filterEndPartnerDocumentDate.toString());

    return await _dio.post(url, data: data, options: options);
  }

  Future<Response> put(String url, {required Options options, data}) async {
    return await _dio.put(url, data: data, options: options);
  }

  Future<Response> delete(String url, {data}) async {
    return await _dio.delete("$url$data");
  }
}
