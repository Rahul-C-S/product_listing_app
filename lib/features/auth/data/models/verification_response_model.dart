import 'package:product_listing_app/features/auth/domain/entities/verification_response.dart';

class VerificationResponseModel extends AuthVerificationResponse {
  VerificationResponseModel({
    required super.otp,
    required super.jwtToken,
    required super.phone,
    required super.user,
  });


}
