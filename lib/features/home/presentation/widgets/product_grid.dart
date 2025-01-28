import 'package:flutter/material.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/presentation/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
    );
  }
}