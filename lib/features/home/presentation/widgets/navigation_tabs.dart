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
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    final navBarWidth =
        isTablet ? screenSize.width * 0.6 : screenSize.width * 0.85;

    final horizontalPadding = isTablet ? 20.0 : 12.0;
    final verticalPadding = isTablet ? 12.0 : 8.0;
    final iconSize = isTablet ? 28.0 : 24.0;
    final fontSize = isTablet ? 18.0 : 16.0;
    final itemSpacing = isTablet ? 24.0 : 16.0;
    final selectedItemPadding = isTablet
        ? const EdgeInsets.symmetric(horizontal: 32, vertical: 16)
        : const EdgeInsets.symmetric(horizontal: 24, vertical: 12);

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
            bottom: isTablet ? 30 : 20,
            child: Center(
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  width: navBarWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNavItem(0, Icons.home_outlined, 'Home', iconSize,
                          fontSize, selectedItemPadding),
                      SizedBox(width: itemSpacing),
                      _buildNavItem(1, Icons.favorite_outline_outlined,
                          'Wishlist', iconSize, fontSize, selectedItemPadding),
                      SizedBox(width: itemSpacing),
                      _buildNavItem(2, Icons.person_outline, 'Profile',
                          iconSize, fontSize, selectedItemPadding),
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

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    double iconSize,
    double fontSize,
    EdgeInsets selectedPadding,
  ) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: isSelected
          ? Container(
              padding: selectedPadding,
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
                    size: iconSize,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: Colors.grey,
              size: iconSize,
            ),
    );
  }
}
