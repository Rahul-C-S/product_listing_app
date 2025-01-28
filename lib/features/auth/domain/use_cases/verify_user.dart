import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/auth/domain/entities/verification_response.dart';
import 'package:product_listing_app/features/auth/domain/repositories/auth_repository.dart';

class VerifyUser
    implements UseCase<AuthVerificationResponse, VerifyUserParams> {
  final AuthRepository _authRepository;

  VerifyUser({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthVerificationResponse>> call(
      VerifyUserParams params) async {
    return await _authRepository.verifyUser(phone: params.phone);
  }
}

class VerifyUserParams {
  final String phone;

  VerifyUserParams({required this.phone});
}
