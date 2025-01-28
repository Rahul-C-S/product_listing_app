
import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/auth/domain/entities/user_data.dart';
import 'package:product_listing_app/features/auth/domain/repositories/auth_repository.dart';

class GetUserData implements UseCase<UserData,NoParams> {
  final AuthRepository _authRepository;

  GetUserData({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserData>> call(NoParams params) async{
return await _authRepository.getUserData();
  }

}