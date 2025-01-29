import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/utils/loader.dart';
import 'package:product_listing_app/core/utils/show_snackbar.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/user_data/user_data_bloc.dart';
import 'package:product_listing_app/features/auth/presentation/widgets/profile_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserDataBloc>(context).add(FetchUserData());
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<UserDataBloc, UserDataState>(
            listener: (context, state) {
              if (state is UserDataFailure) {
                showCustomSnackBar(
                    context: context,
                    message: state.error,
                    type: SnackBarType.error);
              }
              if (state is UserDataLoading) {
                Loader.show(context);
              } else {
                Loader.hide();
              }
            },
            builder: (context, state) {
              if (state is UserDataSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ProfileSection(
                      title: 'Name',
                      content: state.userData.name,

                    ),
                    const SizedBox(height: 16),
                    ProfileSection(
                      title: 'Phone',
                      content: state.userData.phone,

                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
    );
  }
}
