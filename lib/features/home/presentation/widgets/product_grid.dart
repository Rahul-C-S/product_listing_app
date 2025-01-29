import 'package:flutter/material.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/presentation/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int getCrossAxisCount(double width) {
      if (width <= 600) {
        return 2;
      } else if (width <= 900) {
        return 3;
      } else {
        return 4;
      }
    }

    double getChildAspectRatio(double width) {
      if (width <= 600) {
        return 0.65;
      } else {
        return 0.7;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 600 ? 16 : 12,
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(screenWidth),
          childAspectRatio: getChildAspectRatio(screenWidth),
          crossAxisSpacing: screenWidth > 600 ? 12 : 8,
          mainAxisSpacing: screenWidth > 600 ? 12 : 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
    );
  }
}
