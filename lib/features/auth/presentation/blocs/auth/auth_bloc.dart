import 'package:flutter/material.dart';
import 'package:product_listing_app/core/common/cubits/auth/auth_cubit.dart';
import 'package:product_listing_app/features/auth/domain/entities/verification_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/login_register.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/verify_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VerifyUser _verifyUser;
  final LoginRegister _loginRegister;
  final AuthCubit _authCubit;

  AuthBloc({
    required VerifyUser verifyUser,
    required LoginRegister loginRegister,
    required AuthCubit authCubit,
  })  : _verifyUser = verifyUser,
        _loginRegister = loginRegister,
        _authCubit = authCubit,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
    });
    on<AuthLoginRegister>(_onAuthLoginRegister);
    on<AuthVerify>(_onAuthVerify);
  }

  void _onAuthVerify(
    AuthVerify event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _verifyUser(VerifyUserParams(phone: event.phone));

    res.fold(
      (l) => emit(AuthFailure(error: l.message)),
      (r) { 
        _authCubit.updateToken(r.jwtToken);
        emit(AuthVerificationSuccess(authVerificationResponse: r));
      },
    );
  }

  void _onAuthLoginRegister(
    AuthLoginRegister event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _loginRegister(
        LoginRegisterParams(name: event.name, phone: event.phone));

    res.fold(
      (l) => emit(AuthFailure(error: l.message)),
      (r) {
        _authCubit.updateToken(r);
        emit(AuthSuccess(jwtToken: r));
      },
    );
  }
}
