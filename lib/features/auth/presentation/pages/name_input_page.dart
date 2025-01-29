import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/utils/loader.dart';
import 'package:product_listing_app/core/utils/show_snackbar.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:product_listing_app/features/auth/presentation/widgets/back_nav_button.dart';
import 'package:product_listing_app/features/home/presentation/widgets/navigation_tabs.dart';

class NameInputPage extends StatefulWidget {
  final String phone;
  const NameInputPage({
    super.key,
    required this.phone,
  });

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const BackBNavButton(),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showCustomSnackBar(
                  context: context,
                  message: state.error,
                  type: SnackBarType.error);
            }
            if (state is AuthLoading) {
              Loader.show(context);
            } else {
              Loader.hide();
            }

            if (state is AuthSuccess) {
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
            }
          },
          child: Padding(
            padding: getResponsivePadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter full name',
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
                  ),
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      showCustomSnackBar(
                        context: context,
                        message: 'Please enter your name',
                        type: SnackBarType.error,
                      );
                      return;
                    }
                    BlocProvider.of<AuthBloc>(context).add(AuthLoginRegister(
                        name: nameController.text, phone: widget.phone));
                  },
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
      ),
    );
  }
}
