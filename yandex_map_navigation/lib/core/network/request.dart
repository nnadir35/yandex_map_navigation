import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../model/basemodel.dart';

abstract class APIRequests {
  Future<Either<Exception, T>> getRequest<T extends BaseModel>(String path, T model,
      {required Response request}) async {
    try {
      final response = await request;
      final responseBody = response.data;
      if (responseBody is List) {
        responseBody.map((e) => model.fromJson(e)).toList();
        return right(responseBody as T);
      } else if (responseBody is Map) {
        return right(model.fromJson(responseBody as Map<String, dynamic>));
      } else {
        return right(responseBody);
      }
    } on HttpException {
      return left(Exception('İnternet bağlantınızı kontrol edin'));
    } on DioError {
      return left(Exception('Dio error'));
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }
}
