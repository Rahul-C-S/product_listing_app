
import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/repositories/home_repository.dart';

class GetBanners implements UseCase<List<String>,NoParams> {
  final HomeRepository _homeRepository;

  GetBanners({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async{
 return await _homeRepository.getBanners();
  }
}