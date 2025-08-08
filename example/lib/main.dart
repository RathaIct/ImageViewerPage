import 'package:flutter/material.dart';
import 'package:image_viewer_page/image_viewer_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageViewerPage Example',
      theme: ThemeData(useMaterial3: true),
      home: const ImageGridPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImageGridPage extends StatelessWidget {
  // Sample images and corresponding transition styles
  final List<String> imageUrls = const [
    'https://picsum.photos/id/10/800/600',
    'https://picsum.photos/id/20/800/600',
    'https://picsum.photos/id/30/800/600',
    'https://picsum.photos/id/40/800/600',
    'https://picsum.photos/id/50/800/600',
    'https://picsum.photos/id/60/800/600',
  ];

  final List<ImageTransitionStyle> transitionStyles = const [
    ImageTransitionStyle.slide,
    ImageTransitionStyle.fade,
    ImageTransitionStyle.scale,
    ImageTransitionStyle.flip,
    ImageTransitionStyle.cube,
    ImageTransitionStyle.rotate,
  ];

  const ImageGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ImageViewerPage')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ImageViewerNavigator.push(
                context,
                imageUrls: imageUrls,
                initialIndex: index,
                transitionStyle:
                    transitionStyles[index % transitionStyles.length],
              );
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     opaque: false,
              //     barrierColor: Colors.black.withOpacity(0),
              //     pageBuilder: (_, __, ___) => ImageViewerPage(
              //       imageUrls: imageUrls,
              //       initialIndex: index,
              //       transitionStyle:
              //           transitionStyles[index % transitionStyles.length],
              //     ),
              //     transitionsBuilder:
              //         (context, animation, secondaryAnimation, child) {
              //       return FadeTransition(
              //         opacity: animation,
              //         child: child,
              //       );
              //     },
              //   ),
              // );
              /// For Getx navigator
              // Get.to(
              //   () => ImageViewerPage(
              //     imageUrls: imageUrls,
              //     initialIndex: index,
              //     transitionStyle:
              //         transitionStyles[index % transitionStyles.length],
              //   ),
              //   fullscreenDialog: true,
              //   opaque: false, // <-- This is the key!
              //   transition:
              //       Transition.noTransition, // We'll control animation manually
              //   popGesture: true,
              //   curve: Curves.easeInOut,
              // );
            },
            child: Column(
              children: [
                Hero(
                  tag: imageUrls[index],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  transitionStyles[index % transitionStyles.length].name,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
