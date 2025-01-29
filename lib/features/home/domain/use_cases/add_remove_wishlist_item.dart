
import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/repositories/home_repository.dart';

class AddRemoveWishlistItem
    implements UseCase<String, AddRemoveWishlistItemParams> {
  final HomeRepository _homeRepository;

  AddRemoveWishlistItem({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, String>> call(AddRemoveWishlistItemParams params)async {
  return await _homeRepository.addRemoveWishlistItem(productId: params.productId);
  }
}

class AddRemoveWishlistItemParams {
  final int productId;

  AddRemoveWishlistItemParams({required this.productId});
}
