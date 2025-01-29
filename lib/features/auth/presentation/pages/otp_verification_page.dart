import 'package:flutter/material.dart';
import 'package:product_listing_app/core/utils/show_snackbar.dart';
import 'package:product_listing_app/features/auth/domain/entities/verification_response.dart';
import 'package:product_listing_app/features/auth/presentation/pages/name_input_page.dart';
import 'package:product_listing_app/features/auth/presentation/widgets/back_nav_button.dart';
import 'dart:async';
import 'package:product_listing_app/features/home/presentation/widgets/navigation_tabs.dart';

class OTPVerificationPage extends StatefulWidget {
  final AuthVerificationResponse response;

  const OTPVerificationPage({
    super.key,
    required this.response,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  Timer? _timer;
  int _timeLeft = 120;

  double getResponsiveFontSize(double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) return baseSize;
    if (screenWidth <= 900) return baseSize * 1.2;
    return baseSize * 1.4;
  }

  double getResponsiveOTPBoxSize() {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) return 70;
    if (screenWidth <= 900) return 80;
    return 90;
  }

  EdgeInsets getResponsivePadding() {
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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_timeLeft == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  String get formattedTime {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} Sec';
  }

  void onOTPDigitChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      focusNodes[index + 1].requestFocus();
    }
  }

  void verifyOTP() {
    String otp = otpControllers.map((c) => c.text).join();
    if (otp.length != 4) {
      showCustomSnackBar(
        context: context,
        message: 'Please enter a valid 4-digit OTP',
        type: SnackBarType.error,
      );
      return;
    }

    if (widget.response.user) {
      showCustomSnackBar(
        context: context,
        message: 'Login Successful',
        type: SnackBarType.success,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const NavigationTabs()),
        (route) => false,
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NameInputPage(phone: widget.response.phone),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const BackBNavButton(),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: getResponsivePadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OTP VERIFICATION',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(22),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenWidth > 600 ? 20 : 14),
                Row(
                  children: [
                    Text(
                      'Enter the OTP sent to ',
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(14),
                        color: const Color.fromRGBO(99, 99, 99, 1),
                      ),
                    ),
                    Text(
                      '- ${widget.response.phone}',
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(16),
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenWidth > 600 ? 40 : 32),
                Row(
                  children: [
                    Text(
                      'OTP is ',
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(16),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.response.otp,
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(16),
                        color: const Color.fromRGBO(93, 91, 227, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenWidth > 600 ? 40 : 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: getResponsiveOTPBoxSize(),
                      height: getResponsiveOTPBoxSize(),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 246, 1),
                        borderRadius: BorderRadius.circular(
                          screenWidth > 600 ? 14 : 10,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, -3),
                            blurRadius: 4,
                            spreadRadius: -1,
                          ),
                          BoxShadow(
                            color: Colors.white70,
                            offset: Offset(0, -3),
                            blurRadius: 4,
                            spreadRadius: -1,
                          ),
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, -2),
                            blurRadius: 2,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: otpControllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getResponsiveFontSize(24),
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => onOTPDigitChanged(index, value),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth > 600 ? 32 : 24),
                Center(
                  child: Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(16),
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth > 600 ? 24 : 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't receive code? ",
                        style: TextStyle(
                          color: const Color.fromRGBO(112, 112, 112, 1),
                          fontSize: getResponsiveFontSize(15),
                        ),
                      ),
                      TextButton(
                        onPressed: _timeLeft == 0
                            ? () {
                                setState(() {
                                  _timeLeft = 120;
                                });
                                startTimer();
                              }
                            : null,
                        child: Text(
                          'Re-send',
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 229, 163, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: getResponsiveFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth > 600 ? 40 : 30),
                ElevatedButton(
                  onPressed: verifyOTP,
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
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getResponsiveFontSize(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
