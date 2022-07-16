import 'package:clean_arctect/core/models/user_model.dart';

abstract class AppState {}

class InitialState extends AppState {}

class GetUserLoading extends AppState {}

class GetUserSuccess extends AppState {
  GetUserSuccess(UserDataModel r);
}

class GetUserError extends AppState {
  GetUserError(String errorMsg);
}
