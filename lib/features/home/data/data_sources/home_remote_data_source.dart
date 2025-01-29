import 'package:flutter/material.dart';
import 'package:product_listing_app/core/constants/urls.dart';
import 'package:product_listing_app/core/errors/exceptions.dart';
import 'package:product_listing_app/core/utils/web_service.dart';
import 'package:product_listing_app/features/home/data/models/product_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<String>> getBanners();
  Future<List<ProductModel>> getWishList();
  Future<String> addRemoveWishlistItem({
    required int productId,
  });
  Future<List<ProductModel>> search({
    required String query,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final WebService _webService;

  HomeRemoteDataSourceImpl({required WebService webService})
      : _webService = webService;
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _webService.get(
        endpoint: Urls.products,
      );
      if (response.data is List) {
        return (response.data as List)
            .map(
              (e) => ProductModel.fromMap(e),
            )
            .toList();
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<String>> getBanners() async {
    try {
      final response = await _webService.get(
        endpoint: Urls.banners,
      );
      if (response.data is List) {
        return (response.data as List)
            .map(
              (e) => e['image'] as String,
            )
            .toList();
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<String> addRemoveWishlistItem({required int productId}) async {
    try {
      final response =
          await _webService.post(endpoint: Urls.addRemoveWishlist, body: {
        'product_id': productId.toString(),
      });
      if (response.data is Map) {
        return response.data['message'] as String;
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getWishList() async {
    try {
      final response = await _webService.get(
        endpoint: Urls.wishlist,
      );
      if (response.data is List) {
        return (response.data as List)
            .map(
              (e) => ProductModel.fromMap(e),
            )
            .toList();
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> search({required String query}) async {
    try {
      final response =
          await _webService.post(endpoint: Urls.search, body: {'query': query});
      if (response.data is List) {
        return (response.data as List)
            .map(
              (e) => ProductModel.fromMap(e),
            )
            .toList();
      }

      if (response.data == null) {
        throw 'No products found!';
      }

      if (response.data is Map && response.data['message'] != null) {
        throw response.data['message'] as String;
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }
}
