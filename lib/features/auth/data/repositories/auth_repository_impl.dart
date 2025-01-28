import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/exceptions.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:product_listing_app/features/auth/data/models/verification_response_model.dart';
import 'package:product_listing_app/features/auth/domain/entities/user_data.dart';
import 'package:product_listing_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;
  @override
  Future<Either<Failure, String>> loginRegister({
    required String name,
    required String phone,
  }) async {
    try {
      final res =
          await _authRemoteDataSource.loginRegister(name: name, phone: phone);
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, VerificationResponseModel>> verifyUser({
    required String phone,
  }) async {
    try {
      final res = await _authRemoteDataSource.verifyUser(phone: phone);
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserData()async {
    try {
      final res = await _authRemoteDataSource.getUserData();
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
