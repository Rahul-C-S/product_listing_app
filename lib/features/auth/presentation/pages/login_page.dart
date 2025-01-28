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
  final countryCodeController = TextEditingController(text: '91');
  final phoneController = TextEditingController();

  void verifyPhoneNumber() {
    final phoneNumber = '+${countryCodeController.text}${phoneController.text}';

    if (phoneController.text.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: 'Please enter a valid phone number',
        type: SnackBarType.error,
      );
      return;
    }

    BlocProvider.of<AuthBloc>(context).add(
      AuthVerify(
        phone: phoneNumber,
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthFailure){
              showCustomSnackBar(context: context, message: state.error, type: SnackBarType.error,);
            }
            if(state is AuthLoading){
              Loader.show(context);
            }else{
              Loader.hide();
            }

            if(state is AuthVerificationSuccess){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationPage(response: state.authVerificationResponse,),
      ),
    );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Let's Connect with Lorem Ipsum..!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: countryCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '+',
                          hintText: '91',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter Phone',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: verifyPhoneNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By Continuing you accepting the ',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Use & Privacy Policy',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
