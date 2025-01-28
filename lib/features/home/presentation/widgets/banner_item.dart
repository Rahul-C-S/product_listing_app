import 'package:flutter/material.dart';

class BannerItem extends StatelessWidget {
  final String banner;

  const BannerItem({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      // Add width and height constraints
      width: double.infinity,  // or specific width like 200
      height: 200,  // Adjust this value based on your needs
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          banner,
          fit: BoxFit.cover,  // Changed from contain to cover
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}