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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NavigationTabs()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackBNavButton(),
                const SizedBox(height: 24),
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
