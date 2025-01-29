import 'package:flutter/material.dart';

class WishlistButton extends StatefulWidget {
  final bool inWishlist;
  final VoidCallback onPressed;

  const WishlistButton({
    super.key,
    required this.inWishlist,
    required this.onPressed,
  });

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animate() async {
    try {
      await _controller.forward();
      await _controller.reverse();
    } catch (e) {
      debugPrint('Animation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.0,
        end: 1.8,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceIn,
      )),
      child: IconButton(
        icon: Icon(
          Icons.favorite_rounded,
          color: widget.inWishlist 
              ? const Color.fromRGBO(93, 91, 226, 1)
              : Colors.white,
        ),
        iconSize: 24,
        onPressed: () {
          _animate();
          widget.onPressed();
        },
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 36,
          minHeight: 36,
        ),
      ),
    );
  }
}