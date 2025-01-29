import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/utils/loader.dart';
import 'package:product_listing_app/core/utils/show_snackbar.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:product_listing_app/features/auth/presentation/pages/otp_verification_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final countryCodeController = TextEditingController(text: '91');
  final phoneController = TextEditingController();

  
  EdgeInsets getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      return const EdgeInsets.all(24.0);
    } else if (screenWidth <= 900) {
      return const EdgeInsets.symmetric(horizontal: 100.0, vertical: 32.0);
    } else {
      return EdgeInsets.symmetric(
        horizontal: screenWidth * 0.3, 
        vertical: 40.0,
      );
    }
  }

  
  double getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      return baseSize;
    } else if (screenWidth <= 900) {
      return baseSize * 1.2;
    } else {
      return baseSize * 1.4;
    }
  }

  void verifyPhoneNumber() {
    if (_formKey.currentState!.validate()) {
      final phoneNumber =
          '+${countryCodeController.text}${phoneController.text}';

      BlocProvider.of<AuthBloc>(context).add(
        AuthVerify(
          phone: phoneNumber,
        ),
      );
    }
  }

  String? validateCountryCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country code is required';
    }
    if (!RegExp(r'^[0-9]{1,4}$').hasMatch(value)) {
      return 'Enter a valid country code';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[0-9]{8,12}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showCustomSnackBar(
                context: context,
                message: state.error,
                type: SnackBarType.error,
              );
            }
            if (state is AuthLoading) {
              Loader.show(context);
            } else {
              Loader.hide();
            }

            if (state is AuthVerificationSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPVerificationPage(
                    response: state.authVerificationResponse,
                  ),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: getResponsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenWidth > 600 ? 48 : 32),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenWidth > 600 ? 12 : 8),
                    Text(
                      "Let's Connect with Lorem Ipsum..!",
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, 16),
                        color: const Color.fromRGBO(99, 99, 99, 1),
                      ),
                    ),
                    SizedBox(height: screenWidth > 600 ? 64 : 48),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: countryCodeController,
                            keyboardType: TextInputType.number,
                            validator: validateCountryCode,
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 14),
                            ),
                            decoration: InputDecoration(
                              prefixText: '+',
                              hintText: '91',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              errorStyle: TextStyle(
                                fontSize: getResponsiveFontSize(context, 12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: screenWidth > 600 ? 6 : 5,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: validatePhoneNumber,
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 14),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter Phone',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: getResponsiveFontSize(context, 14),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              errorStyle: TextStyle(
                                fontSize: getResponsiveFontSize(context, 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth > 600 ? 40 : 30),
                    ElevatedButton(
                      onPressed: verifyPhoneNumber,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        minimumSize: Size(
                          double.infinity,
                          screenWidth > 600 ? 64 : 56,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth > 600 ? 20 : 16,
                          ),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getResponsiveFontSize(context, 16),
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth > 600 ? 28 : 22),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By Continuing you accepting the ',
                          style: TextStyle(
                            color: const Color.fromRGBO(100, 100, 100, 1),
                            fontSize: getResponsiveFontSize(context, 12),
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms of Use & Privacy Policy',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getResponsiveFontSize(context, 12),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth > 600 ? 32 : 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}