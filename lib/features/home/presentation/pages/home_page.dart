import 'package:flutter/material.dart';
import 'package:product_listing_app/features/home/presentation/widgets/banner_slider.dart';
import 'package:product_listing_app/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:product_listing_app/features/home/presentation/widgets/product_grid.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(),
          BannerSlider(banners: _getBanners()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Popular Product',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ProductGrid(products: _getProducts()),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getBanners() {
    return [
      {
        'title': 'Paragon Kitchen - Lulu Mall',
        'discount': 'Flat 50% Off!',
        'image': 'assets/burger.png',
      },
      // Add more banners
    ];
  }

  List<Map<String, dynamic>> _getProducts() {
    return [
      {
        'name': 'Grain Peppers',
        'price': 599,
        'originalPrice': 800,
        'rating': 4.5,
        'image': 'assets/grain_peppers.jpg',
      },
      {
        'name': 'Organic Dry Turmeric',
        'price': 599,
        'originalPrice': 800,
        'rating': 4.5,
        'image': 'assets/turmeric.jpg',
      },
      // Add more products
    ];
  }
}