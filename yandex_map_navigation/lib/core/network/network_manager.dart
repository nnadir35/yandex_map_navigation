import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:yandex_map_navigation/core/network/request.dart';

import '../model/basemodel.dart';
import 'network_interceptor.dart';

class MapboxNetworkManager extends APIRequests {
  static MapboxNetworkManager? _instance;

  Dio? dio;

  factory MapboxNetworkManager({Map<String, dynamic>? queryParameters}) {
    _instance ??= MapboxNetworkManager._init(queryParameters: queryParameters);
    return _instance!;
  }

  MapboxNetworkManager._init({Map<String, dynamic>? queryParameters}) {
    BaseOptions baseOptions = BaseOptions(baseUrl: 'https://api.mapbox.com/', queryParameters: queryParameters);
    dio = Dio(baseOptions);
    dio!.interceptors.add(NetworkInterceptor());
  }
  Future<Either<Exception, T>> get<T extends BaseModel>(String path, T model) async {
    var request = await dio!.get(path);
    return super.getRequest(path, model, request: request);
  }
}
