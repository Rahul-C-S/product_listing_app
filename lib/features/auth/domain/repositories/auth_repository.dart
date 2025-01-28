import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/features/auth/domain/entities/verification_response.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthVerificationResponse>> verifyUser({
    required String phone,
  });
  Future<Either<Failure, String>> loginRegister({
    required String name,
    required String phone,
  });
}
