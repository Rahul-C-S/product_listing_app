
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void updateToken(String? token){
    if(token == null){
      emit(AuthInitial());
    }else{
      emit(AuthSuccess(jwtToken: token));
    }
  }
}
