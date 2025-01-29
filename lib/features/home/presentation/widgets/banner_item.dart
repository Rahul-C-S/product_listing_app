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
      
      width: double.infinity,  
      height: 200,  
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          banner,
          fit: BoxFit.cover,  
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}