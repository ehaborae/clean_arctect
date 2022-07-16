import 'package:clean_arctect/core/error/failures.dart';
import 'package:clean_arctect/core/models/user_model.dart';
import 'package:clean_arctect/features/splash/data/remote/get_user_remote.dart';
import 'package:clean_arctect/features/splash/domain/repo/get_user_data_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserRepoImp extends GetUserRepo {
  RemoteGerUser remoteGerUserImp = RemoteGerUser(dioHelper: null);

  @override
  Future<Either<Failure, UserDataModel>> getUser(String userId) async {
    try {
      final data = await remoteGerUserImp.signUp(
          name: 'name', password: 'password', email: 'email', phone: 'phone');
      return Right(data);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
