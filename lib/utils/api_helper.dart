import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/entities/api_response.dart';

class ApiBaseHelper {
  static var dio = createDio();

  static BaseOptions opts = BaseOptions(
    baseUrl: 'https://rickandmortyapi.com',
    responseType: ResponseType.json,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio..interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<ApiResponse> getHttp(String url) async {
    ApiResponse apiResponse = ApiResponse(message: '', data: null, status: 200);
    try {
      Response response = await dio.get(url);
      apiResponse.data = response.data;
      return apiResponse;
    } catch (e) {
      apiResponse = _getDioError(e);
    }
    return apiResponse;
  }

  Future<ApiResponse> postHttp(String url, dynamic data) async {
    ApiResponse apiResponse = ApiResponse(message: '', data: null, status: 200);
    try {
      Response response = await dio.post(url, data: data);
      apiResponse.data = response.data;
      apiResponse.status = response.statusCode!;
      return apiResponse;
    } catch (e) {
      apiResponse = _getDioError(e);
    }
    return apiResponse;
  }

  Future<ApiResponse> deleteHttp(String url) async {
    ApiResponse apiResponse = ApiResponse(message: '', data: null, status: 200);
    try {
      Response response = await dio.delete(url);
      apiResponse.data = response.data;
      apiResponse.status = response.statusCode!;
      return apiResponse;
    } catch (e) {
      apiResponse = _getDioError(e);
    }
    return apiResponse;
  }

  Future<ApiResponse> putHttp(String url, dynamic data) async {
    ApiResponse apiResponse = ApiResponse(message: '', data: null, status: 200);
    try {
      Response response = await dio.put(url, data: data);
      apiResponse.data = response.data;
      apiResponse.status = response.statusCode!;
      return apiResponse;
    } catch (e) {
      apiResponse = _getDioError(e);
    }
    return apiResponse;
  }

  ApiResponse _getDioError(e) {
    ApiResponse apiResponse = ApiResponse(message: '', data: null, status: 500);
    if (e is Exception) {
      if (e is DioError) {
        switch (e.type) {
          case DioErrorType.response:
            switch (e.response!.statusCode) {
              case 400:
                apiResponse.message = 'Ha ocurrido algo \n intente mas tarde';

                apiResponse.status = 400;
                break;
              case 401:
                apiResponse.message = 'Ha ocurrido algo \n intente mas tarde';
                apiResponse.status = 401;
                break;
              case 403:
                apiResponse.message = 'Ha ocurrido algo \n intente mas tarde';
                apiResponse.status = 403;
                break;
              case 404:
                apiResponse.message =
                    'Ha ocurrido algo \n no se encuentra la pagina';
                apiResponse.status = 404;
                break;
              case 500:
                apiResponse.message =
                    'Ha ocurrido algo \n Problemas en el servidor';
                apiResponse.status = 500;
                break;
              case 502:
                apiResponse.message =
                    'Ha ocurrido algo \n Problemas en el servidor';
                apiResponse.status = 500;
                break;
              default:
                var responseCode = e.response!.statusCode;
                apiResponse.message = 'Ha ocurrido algo \n intente mas tarde';
                apiResponse.status = responseCode!;
            }
            break;
          case DioErrorType.connectTimeout:
            apiResponse.status = 500;
            apiResponse.message = 'Problemas con la conexion a internet';
            break;
          case DioErrorType.sendTimeout:
            apiResponse.status = 400;
            apiResponse.message = e.message + e.error.toString();
            break;
          case DioErrorType.receiveTimeout:
            apiResponse.status = 400;
            apiResponse.message = 'Problemas con la conexion a internet';
            break;
          case DioErrorType.cancel:
            apiResponse.status = 400;
            apiResponse.message = e.message + e.error.toString();
            break;
          case DioErrorType.other:
            apiResponse.status = 500;
            apiResponse.message = 'Problemas con la conexion a internet';
            break;
        }
      } else if (e is SocketException) {
        apiResponse.message = 'No tienes acceso a internet';
      }
    } else {
      apiResponse.message = 'Ha ocurrido un error';
    }
    return apiResponse;
  }
}
