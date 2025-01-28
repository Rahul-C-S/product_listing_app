import 'package:flutter/material.dart';
import 'package:product_listing_app/features/auth/presentation/pages/profile_page.dart';
import 'package:product_listing_app/features/home/presentation/pages/home_page.dart';
import 'package:product_listing_app/features/wish_list/presentation/pages/wish_list_page.dart';

class NavigationTabs extends StatefulWidget {
  const NavigationTabs({super.key});

  @override
  State<NavigationTabs> createState() => _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const WishListPage(),
    const ProfilePage(), // Profile page placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20,left: 30,right: 30,),
        padding: EdgeInsets.symmetric(vertical: 8,),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home_outlined, 'Home'),
            _buildNavItem(1, Icons.favorite_outline_outlined, 'Wishlist'),
            _buildNavItem(2, Icons.person_outline, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF5C4FE1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: Colors.grey,
              size: 24,
            ),
    );
  }
}
