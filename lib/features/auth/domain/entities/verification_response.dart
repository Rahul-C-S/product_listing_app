class AuthVerificationResponse {
  final String otp;
  final String? jwtToken;
  final String phone;
  final bool user;

  AuthVerificationResponse({required this.otp, required this.jwtToken,required this.phone, required this.user,});

  
}
