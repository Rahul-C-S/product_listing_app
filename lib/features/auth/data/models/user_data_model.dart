import 'dart:convert';

import 'package:product_listing_app/features/auth/domain/entities/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel({
    required super.name,
    required super.phone,
  });




  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      name: map['name'] as String,
      phone: map['phone_number'] as String,
    );
  }


  factory UserDataModel.fromJson(String source) => UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
