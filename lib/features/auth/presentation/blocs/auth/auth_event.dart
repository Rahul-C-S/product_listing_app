part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthVerify extends AuthEvent {
  final String phone;

  AuthVerify({required this.phone});
}

final class AuthLoginRegister extends AuthEvent {
  final String name;
  final String phone;

  AuthLoginRegister({
    required this.name,
    required this.phone,
  });
}
