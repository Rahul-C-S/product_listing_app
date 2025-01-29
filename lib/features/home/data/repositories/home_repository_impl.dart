import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/exceptions.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:product_listing_app/features/home/data/models/product_model.dart';
import 'package:product_listing_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl({required HomeRemoteDataSource homeRemoteDataSource})
      : _homeRemoteDataSource = homeRemoteDataSource;

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final res = await _homeRemoteDataSource.getProducts();
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getBanners() async {
    try {
      final res = await _homeRemoteDataSource.getBanners();
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addRemoveWishlistItem(
      {required int productId}) async {
    try {
      final res = await _homeRemoteDataSource.addRemoveWishlistItem(
        productId: productId,
      );
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getWishList() async {
    try {
      final res = await _homeRemoteDataSource.getWishList();
      return right(res);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
