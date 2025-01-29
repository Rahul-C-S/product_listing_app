import 'package:flutter/material.dart';

class BackBNavButton extends StatelessWidget {
  const BackBNavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back,color: Color.fromRGBO(128, 128, 128, 1)),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
