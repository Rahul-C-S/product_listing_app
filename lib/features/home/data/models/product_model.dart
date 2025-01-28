import 'dart:convert';

import 'package:product_listing_app/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.mrp,
    required super.price,
    required super.isActive,
    required super.inWishlist,
   required super.image,
   required super.rating,
  });



  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      mrp: map['mrp'] is int ? (map['mrp'] as int).toDouble() : map['mrp'] as double,
      price: map['sale_price'] is int ? (map['sale_price'] as int).toDouble() : map['sale_price'] as double,
      isActive: map['is_active'] as bool,
      inWishlist: map['in_wishlist'] as bool,
      image: map['featured_image'] as String,
      rating: map['avg_rating'] is int ? (map['avg_rating'] as int).toDouble() : map['avg_rating'] as double,
    );
  }


  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
