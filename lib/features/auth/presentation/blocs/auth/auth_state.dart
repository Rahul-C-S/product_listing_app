part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}

final class AuthVerificationSuccess extends AuthState {
  final AuthVerificationResponse authVerificationResponse;

  AuthVerificationSuccess({required this.authVerificationResponse});
}

final class AuthSuccess extends AuthState {
  final String jwtToken;

  AuthSuccess({required this.jwtToken});
}
