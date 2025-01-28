import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/auth/domain/repositories/auth_repository.dart';

class LoginRegister implements UseCase<String, LoginRegisterParams> {
  final AuthRepository _authRepository;

  LoginRegister({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, String>> call(LoginRegisterParams params) async {
    return await _authRepository.loginRegister(
      name: params.name,
      phone: params.phone,
    );
  }
}

class LoginRegisterParams {
  final String name;
  final String phone;

  LoginRegisterParams({required this.name, required this.phone});
}
