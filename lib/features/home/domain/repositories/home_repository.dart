import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';

abstract interface class HomeRepository {
  Future<Either<Failure,List<Product>>> getProducts();
  Future<Either<Failure,List<String>>> getBanners();
  // Future<Either<Failure,
}