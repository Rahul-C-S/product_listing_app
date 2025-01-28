part of 'user_data_bloc.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}
final class UserDataLoading extends UserDataState {}
final class UserDataFailure extends UserDataState {
  final String error;

  UserDataFailure({required this.error});
}
final class UserDataSuccess extends UserDataState {
  final UserData userData;

  UserDataSuccess({required this.userData});
}
