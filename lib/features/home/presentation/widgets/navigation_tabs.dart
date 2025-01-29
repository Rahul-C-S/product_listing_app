import 'package:flutter/material.dart';
import 'package:product_listing_app/features/auth/presentation/pages/profile_page.dart';
import 'package:product_listing_app/features/home/presentation/pages/home_page.dart';
import 'package:product_listing_app/features/home/presentation/pages/wish_list_page.dart';

class NavigationTabs extends StatefulWidget {
  const NavigationTabs({super.key});

  @override
  State<NavigationTabs> createState() => _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    _pages = [
      HomePage(
        index: 0,
        tabController: _tabController,
      ),
      WishListPage(
        tabController: _tabController,
        index: 1,
      ),
      const ProfilePage(),
    ];
  }

  void _handleTabSelection() {
    if (!mounted) return;
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNavItem(0, Icons.home_outlined, 'Home'),
                      const SizedBox(width: 16),
                      _buildNavItem(
                          1, Icons.favorite_outline_outlined, 'Wishlist'),
                      const SizedBox(width: 16),
                      _buildNavItem(2, Icons.person_outline, 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
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
