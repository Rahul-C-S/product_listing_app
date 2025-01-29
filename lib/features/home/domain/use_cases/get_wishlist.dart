
import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/domain/repositories/home_repository.dart';

class GetWishlist implements UseCase<List<Product>, NoParams> {
  final HomeRepository _homeRepository;

  GetWishlist({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async{
 return await _homeRepository.getWishList();
  }
}