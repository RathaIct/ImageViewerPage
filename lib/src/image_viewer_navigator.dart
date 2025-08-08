import 'package:flutter/material.dart';
import 'package:image_viewer_page/image_viewer_page.dart';

class ImageViewerNavigator {
  static void push(
    BuildContext context, {
    required List<String> imageUrls,
    required int initialIndex,
    ImageTransitionStyle transitionStyle = ImageTransitionStyle.slide,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0),
        pageBuilder: (_, __, ___) => ImageViewerPage(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
          transitionStyle: transitionStyle,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
