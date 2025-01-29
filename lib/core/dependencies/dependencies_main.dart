part of 'dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> injectDependencies() async {
  serviceLocator.registerLazySingleton(
    () => WebService(),
  );

  // _injectOnBoarding();
  _injectHome();
  _injectCore();
  _injectAuth();
}

void _injectCore() {
  serviceLocator.registerLazySingleton(
    () => AuthCubit(),
  );
}

void _injectAuth() {
  // Data sources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        webService: serviceLocator(),
      ),
    )

// Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
      ),
    )
// Use cases
    ..registerFactory(
      () => LoginRegister(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => VerifyUser(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUserData(
        authRepository: serviceLocator(),
      ),
    )

// Blocs
    ..registerLazySingleton(
      () => UserDataBloc(
        getUserData: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        loginRegister: serviceLocator(),
        verifyUser: serviceLocator(),
        authCubit: serviceLocator(),
      ),
    );
}

void _injectHome() {
// Data sources

  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        webService: serviceLocator(),
      ),
    )

// Repositories
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(
        homeRemoteDataSource: serviceLocator(),
      ),
    )

// Use cases
    ..registerFactory(
      () => GetBanners(
        homeRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetProducts(
        homeRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetWishlist(
        homeRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => AddRemoveWishlistItem(
        homeRepository: serviceLocator(),
      ),
    )

// Blocs
    ..registerLazySingleton(
      () => BannerBloc(
        getBanners: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => MenuBloc(
        getProducts: serviceLocator(),
        addRemoveWishlistItem: serviceLocator(),
        getWishlist: serviceLocator(),
      ),
    );
}

// Data sources

// Repositories

// Use cases

// Blocs
