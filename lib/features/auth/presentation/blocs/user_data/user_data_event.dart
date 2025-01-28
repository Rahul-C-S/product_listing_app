part of 'user_data_bloc.dart';

@immutable
sealed class UserDataEvent {}

final class FetchUserData extends UserDataEvent{}
