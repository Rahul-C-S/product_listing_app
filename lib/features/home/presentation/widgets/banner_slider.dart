import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:product_listing_app/features/home/presentation/widgets/banner_item.dart';

class BannerSlider extends StatelessWidget {
  final List<Map<String, dynamic>> banners;

  const BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        aspectRatio: 16/9,
        viewportFraction: 0.95,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: banners.map((banner) => BannerItem(banner: banner)).toList(),
    );
  }
}

