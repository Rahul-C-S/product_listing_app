import 'package:get_it/get_it.dart';
import 'package:product_listing_app/core/common/cubits/auth/auth_cubit.dart';
import 'package:product_listing_app/core/utils/web_service.dart';
import 'package:product_listing_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:product_listing_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:product_listing_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/get_user_data.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/login_register.dart';
import 'package:product_listing_app/features/auth/domain/use_cases/verify_user.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:product_listing_app/features/auth/presentation/blocs/user_data/user_data_bloc.dart';
import 'package:product_listing_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:product_listing_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:product_listing_app/features/home/domain/repositories/home_repository.dart';
import 'package:product_listing_app/features/home/domain/use_cases/add_remove_wishlist_item.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_banners.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_products.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_wishlist.dart';
import 'package:product_listing_app/features/home/domain/use_cases/search_product.dart';
import 'package:product_listing_app/features/home/presentation/blocs/banner/banner_bloc.dart';
import 'package:product_listing_app/features/home/presentation/blocs/menu/menu_bloc.dart';


part 'dependencies_main.dart';
