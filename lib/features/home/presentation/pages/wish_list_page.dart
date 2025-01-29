import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/utils/loader.dart';
import 'package:product_listing_app/core/utils/show_snackbar.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/presentation/blocs/menu/menu_bloc.dart';
import 'package:product_listing_app/features/home/presentation/widgets/product_grid.dart';

class WishListPage extends StatefulWidget {
  final TabController tabController;
  final int index;

  const WishListPage({
    super.key,
    required this.tabController,
    required this.index,
  });

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List<Product> products = [];

  void _loadList() {
    context.read<MenuBloc>().add(FetchWishlist());
  }

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabSelection);
    _loadList();
  }

  void _handleTabSelection() {
    if (widget.tabController.index == widget.index) {
      _loadList();
    }
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  
  EdgeInsets _getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) {
      return const EdgeInsets.symmetric(horizontal: 64, vertical: 16);
    } else if (width > 600) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 12);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  }

  
  double _getResponsiveFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) {
      return 28;
    } else if (width > 600) {
      return 24;
    }
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final responsivePadding = _getResponsivePadding(context);
    final responsiveFontSize = _getResponsiveFontSize(context);

    return BlocListener<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is MenuFailure) {
          showCustomSnackBar(
            context: context,
            message: state.error,
            type: SnackBarType.error,
          );
        }

        if (state is MenuLoading) {
          Loader.show(context);
        } else {
          Loader.hide();
        }

        if (state is WishListUpdateSuccess) {
          _loadList();
        }

        if (state is WishlistFetchSuccess) {
          setState(() {
            products = state.products;
          });
        }
      },
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: responsivePadding,
                  child: Text(
                    'Wishlist',
                    style: TextStyle(
                      fontSize: responsiveFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (products.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Your wishlist is empty',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Padding(
                      padding: responsivePadding.copyWith(top: 0),
                      child: ProductGrid(
                        products: products,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
