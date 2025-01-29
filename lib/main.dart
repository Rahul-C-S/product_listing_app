import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/common/cubits/auth/auth_cubit.dart';
import 'package:product_listing_app/core/dependencies/dependencies.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/user_data/user_data_bloc.dart';
import 'package:product_listing_app/features/home/presentation/blocs/banner/banner_bloc.dart';
import 'package:product_listing_app/features/home/presentation/blocs/menu/menu_bloc.dart';
import 'package:product_listing_app/features/splash/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize dependencies
  await injectDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MenuBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<BannerBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserDataBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Listing App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
