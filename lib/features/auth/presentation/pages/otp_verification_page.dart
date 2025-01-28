import 'package:flutter/material.dart';
import 'package:product_listing_app/core/utils/show_snackbar.dart';
import 'package:product_listing_app/features/auth/domain/entities/verification_response.dart';
import 'package:product_listing_app/features/auth/presentation/pages/name_input_page.dart';
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

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationTabs()),
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NameInputPage(phone: widget.response.phone),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'OTP VERIFICATION',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter the OTP sent to - ${widget.response.phone}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        // Top inner shadow (darker)
                        const BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: -1,
                        ),
                        // Bottom inner shadow (lighter)
                        const BoxShadow(
                          color: Colors.white70,
                          offset: Offset(0, -3),
                          blurRadius: 3,
                          spreadRadius: -1,
                        ),
                        // Subtle outer edge shadow
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
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
                      style: const TextStyle(
                        fontSize: 24,
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
              const SizedBox(height: 24),
              Center(
                child: Text(
                  formattedTime,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't receive code? ",
                      style: TextStyle(
                        color: Colors.black54,
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
                          color: _timeLeft == 0 ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: verifyOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
