import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:product_listing_app/features/home/presentation/widgets/banner_item.dart';

class BannerSlider extends StatefulWidget {
  final List<String> banners;

  const BannerSlider({super.key, required this.banners});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentIndex = 0;

  double getBannerHeight(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      return 180;
    } else if (screenWidth <= 900) {
      return 250;
    } else {
      return 300;
    }
  }

  double getViewportFraction(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      return 0.95;
    } else if (screenWidth <= 900) {
      return 0.85;
    } else {
      return 0.75;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: getBannerHeight(context),
            aspectRatio: screenWidth > 600 ? 21 / 9 : 16 / 9,
            viewportFraction: getViewportFraction(context),
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.banners
              .map((banner) => BannerItem(banner: banner))
              .toList(),
        ),
        SizedBox(height: screenWidth > 600 ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key
                  ? (screenWidth > 600 ? 25 : 20)
                  : (screenWidth > 600 ? 10 : 8),
              height: screenWidth > 600 ? 10 : 8,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth > 600 ? 6 : 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  screenWidth > 600 ? 5 : 4,
                ),
                color: _currentIndex == entry.key
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade400,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
