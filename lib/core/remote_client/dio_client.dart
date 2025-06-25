import 'package:book_application/utils/app_utils.dart';
import 'package:dio/dio.dart';

class DioClient {
  Dio? dio;

  DioClient.defaultClient(
      {BaseOptions? baseOptions, required Map<String, dynamic> header}) {
    header['Access-Control-Allow-Origin'] = '*';

    if (baseOptions == null) {
      baseOptions = BaseOptions(
          headers: header,
          baseUrl: AppUtils.appNetworks.base_url,
          connectTimeout: const Duration(seconds: 120),
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          receiveTimeout: const Duration(seconds: 120));
    }
    dio = Dio(baseOptions);
  }
}
