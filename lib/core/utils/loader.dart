import 'package:flutter/material.dart';

class Loader {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) {
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.479),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
