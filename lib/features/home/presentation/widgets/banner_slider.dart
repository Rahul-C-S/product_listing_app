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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            aspectRatio: 16 / 9,
            viewportFraction: 0.95,
            autoPlay: true,
            enlargeCenterPage: true,
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 20 : 8, 
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(4), 
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
