import 'package:get_it/get_it.dart';
import 'package:product_listing_app/core/common/cubits/auth/auth_cubit.dart';
import 'package:product_listing_app/core/utils/web_service.dart';
import 'package:product_listing_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:product_listing_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:product_listing_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/login_register.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/verify_user.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/auth/auth_bloc.dart';


part 'dependencies_main.dart';
