import 'package:clean_arctect/core/models/user_model.dart';
import 'package:clean_arctect/core/util/cubit/app_states.dart';
import 'package:clean_arctect/features/splash/domain/repo_imp/get_user_data_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  final GetUserRepoImp _repository;

  AppCubit({
    required GetUserRepoImp repository,
  })  : _repository = repository,
        super(InitialState());

  UserDataModel? userDataModel;

  getUserData(String userId) async {
    emit(GetUserLoading());

    await _repository.getUser(userId).then((value) {
      value.fold((l) => emit(GetUserError(l.toString())), (r) {
        userDataModel = r;
        emit(GetUserSuccess(r));
      });
    });
  }
}
