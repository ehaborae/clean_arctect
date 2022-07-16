import 'package:clean_arctect/core/error/exceptions.dart';
import 'package:clean_arctect/core/util/network/remote/api_endpoints.dart';
import 'package:clean_arctect/core/util/network/remote/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class RemoteGerUser {
  final DioHelper dioHelper;

  RemoteGerUser({
    required this.dioHelper,
  });

  Future<Either<String, dynamic>> signUp({
    required String name,
    required String password,
    required String email,
    required String phone,
  }) async {
    return _basicErrorHandling(
      onSuccess: () async {
        final Response f = await dioHelper.post(url: signUpUrl, data: {
          'params': {
            'name': name,
            'password': password,
            'email': email,
            'phone': phone,
          },
        });
        return f.data;
      },
      onServerError: (exception) async {
        return exception.message;
      },
      onOtherError: (exception) async {
        return exception.token;
      },
      onCacheError: (exception) async {
        return exception.message;
      },
    );
  }
}


extension on RemoteGerUser {
  Future<Either<String, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<String> Function(ServerException exception)? onServerError,
    Future<String> Function(CacheException exception)? onCacheError,
    Future<String> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on ServerException catch (e) {
      // recordError(e, s);
      // debugPrint(s.toString());
      if (onServerError != null) {
        final f = await onServerError(e);
        return Left(f);
      }
      return const Left('Server Error');
    } on CacheException catch (e) {
      // recordError(e, s);
      debugPrint(e.toString());
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return const Left('Cache Error');
    } catch (e) {
      // recordError(e, s);
      // debugPrint(s.toString());
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(e.toString());
    }
  }
}