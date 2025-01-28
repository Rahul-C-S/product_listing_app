
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/auth/domain/entities/user_data.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/get_user_data.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final GetUserData _getUserData;
  UserDataBloc({required GetUserData getUserData}) : _getUserData = getUserData, super(UserDataInitial()) {
    on<UserDataEvent>((event, emit) {
    emit(UserDataLoading());
    });
    on<FetchUserData>(_onFetchUserData);
  }

  void _onFetchUserData(FetchUserData event, Emitter<UserDataState> emit,)async{
    final res = await _getUserData(NoParams());
    res.fold((l) => emit(UserDataFailure(error: l.message)), (r) => emit(UserDataSuccess(userData: r)),);
  }
}
