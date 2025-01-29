import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/utils/loader.dart';
import 'package:product_listing_app/core/utils/show_snackbar.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/presentation/blocs/banner/banner_bloc.dart';
import 'package:product_listing_app/features/home/presentation/blocs/menu/menu_bloc.dart';
import 'package:product_listing_app/features/home/presentation/widgets/banner_slider.dart';
import 'package:product_listing_app/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:product_listing_app/features/home/presentation/widgets/product_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];
  List<String> _banners = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BannerBloc>(context).add(FetchBanners());
    _loadMenu();
  }

  void _loadMenu() {
    BlocProvider.of<MenuBloc>(context).add(FetchMenu());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<MenuBloc, MenuState>(
              listener: (context, state) {
                if (state is MenuLoading) {
                  Loader.show(context);
                } else {
                  Loader.hide();
                }

                if (state is ProductSuccess) {
                  setState(() {
                    _products = state.products;
                  });
                }

                if (state is WishListUpdateSuccess) {
                  showCustomSnackBar(
                      context: context,
                      message: state.message,
                      type: SnackBarType.success);
                  _loadMenu();
                }

                if (state is MenuFailure) {
                  showCustomSnackBar(
                    context: context,
                    message: state.error,
                    type: SnackBarType.error,
                  );
                }
              },
            ),
            BlocListener<BannerBloc, BannerState>(
              listener: (context, state) {
                if (state is BannerLoading) {
                  Loader.show(context);
                } else {
                  Loader.hide();
                }

                if (state is BannerSuccess) {
                  _banners = state.banners;
                }
                if (state is BannerFailure) {
                  showCustomSnackBar(
                    context: context,
                    message: state.error,
                    type: SnackBarType.error,
                  );
                }
              },
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(),
              BannerSlider(banners: _banners),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ProductGrid(products: _products),
            ],
          ),
        ),
      ),
    );
  }
}
