import 'package:flutter/material.dart';
import 'package:product_listing_app/core/constants/urls.dart';
import 'package:product_listing_app/core/errors/exceptions.dart';
import 'package:product_listing_app/core/utils/web_service.dart';
import 'package:product_listing_app/features/auth/data/models/user_data_model.dart';
import 'package:product_listing_app/features/auth/data/models/verification_response_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<VerificationResponseModel> verifyUser({
    required String phone,
  });
  Future<String> loginRegister({
    required String name,
    required String phone,
  });
  Future<UserDataModel> getUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final WebService _webService;

  AuthRemoteDataSourceImpl({
    required WebService webService,
  }) : _webService = webService;
  @override
  Future<String> loginRegister({
    required String name,
    required String phone,
  }) async {
    try {
      final response = await _webService.post(
        endpoint: Urls.login,
        body: {
          'first_name': name,
          'phone_number': phone,
        },
      );

      if (response.data is Map) {
        _webService.setAuthToken(response.data['token']['access']);
        return response.data['token']['access'] as String;
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<VerificationResponseModel> verifyUser({
    required String phone,
  }) async {
    try {
      final response = await _webService.post(
        endpoint: Urls.verify,
        body: {
          'phone_number': phone,
        },
      );

      if (response.data is Map) {
        if (response.data['token'] != null) {
          _webService.setAuthToken(response.data['token']['access']);
        }
        return VerificationResponseModel(
          otp: response.data['otp'] is int
              ? response.data['otp'].toString()
              : response.data['otp'],
          jwtToken: response.data['token'] == null
              ? null
              : response.data['token']['access'] as String,
          phone: phone,
          user: response.data['user'] as bool,
        );
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }

  @override
  Future<UserDataModel> getUserData() async {
    try {
      final response = await _webService.get(endpoint: Urls.userData);

      if (response.data is Map) {
        return UserDataModel.fromMap(response.data);
      }

      throw "Unexpected error!";
    } catch (e, s) {
      debugPrint(s.toString());
      throw AppException(e.toString());
    }
  }
}
