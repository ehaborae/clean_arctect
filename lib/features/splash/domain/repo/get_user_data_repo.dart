import 'package:clean_arctect/core/error/failures.dart';
import 'package:clean_arctect/core/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class GetUserRepo {
  Future<Either<Failure, UserDataModel>> getUser(String userId);
}