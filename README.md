# ImageViewerPage

[ImageViewerPage](https://pub.dev/packages/image_viewer_page) ជួយអ្នកបង្ហាញរូបភាពជាស្រឡាយ និងអាចធ្វើចលនាប្លង់ចេញចូល (transitions) ដូចជា: flip, fade, rotate, scale និង cube!

[ImageViewerPage](https://pub.dev/packages/image_viewer_page) helps you create beautiful full-screen image viewers with gesture control, zoom, swipe-to-dismiss, and animated transitions.

<hr />
<p align="center">
  <img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/home.gif"/>
</p>
<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg" alt="Platform" />
  </a>
  <a href="https://pub.dev/packages/image_viewer_page">
    <img src="https://img.shields.io/pub/v/image_viewer_page.svg" alt="Pub Package" />
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-red.svg" alt="License: MIT" />
  </a>
  <a href="https://github.com/RathaIct/ImageViewerPage/issues">
    <img src="https://img.shields.io/github/issues/RathaIct/ImageViewerPage" alt="Issue" />
  </a>
  <a href="https://github.com/RathaIct/ImageViewerPage/network">
    <img src="https://img.shields.io/github/forks/RathaIct/ImageViewerPage" alt="Forks" />
  </a>
  <a href="https://github.com/RathaIct/ImageViewerPage/stargazers">
    <img src="https://img.shields.io/github/stars/RathaIct/ImageViewerPage" alt="Stars" />
  </a>
</p>

## 🧩Features

<table>
  <thead>
    <tr>
      <th style="text-align:left;">✅ Feature</th>
      <th style="text-align:left;">Description</th>
      <th style="text-align:left;">Preview</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Pinch to Zoom</strong></td>
      <td>Use two fingers to zoom in and out</td>
      <td><img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/pinch_zoom.gif" width="200"/></td>
    </tr>
    <tr>
      <td><strong>Double Tap to Zoom</strong></td>
      <td>Quickly zoom in or out by double tapping</td>
      <td><img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/touble_tap_zoom.gif" width="200"/></td>
    </tr>
    <tr>
      <td><strong>Swipe to Dismiss</strong></td>
      <td>Swipe up or down to dismiss the viewer</td>
      <td><img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/dismiss.gif" width="200"/></td>
    </tr>
    <tr>
      <td><strong>Transition Styles</strong></td>
      <td>Choose from: <code>slide</code>, <code>fade</code>, <code>scale</code>, <code>flip</code>, <code>rotate</code>, <code>cube</code></td>
      <td><img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/transition.gif" width="200"/></td>
    </tr>
    <tr>
      <td><strong>Page Indicator Overlay</strong></td>
      <td>Shows current image index at the top right</td>
      <td>—</td>
    </tr>
    <tr>
      <td><strong>Hero Animation Support</strong></td>
      <td>Smooth shared-element animation from thumbnail to fullscreen</td>
      <td>—</td>
    </tr>
  </tbody>
</table>

## Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  image_viewer_page: ^1.0.3
```

### 2. Install it

```bash
flutter pub get
```

### 3. Import it

```dart
import 'package:image_viewer_page/image_viewer_page.dart';
```

## Usage

Create a full-screen image viewer with optional animated transition:

```dart
 // Use custom Navigator of ImageViewerPage
 ImageViewerNavigator.push(
    context,
    imageUrls: [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
      ],
    initialIndex: 0, // index image when user tap
    transitionStyle: ImageTransitionStyle.flip,
  );
// Handle with flutter navigator
Navigator.of(context).push(
  PageRouteBuilder(
    opaque: false,
    barrierColor: Colors.black.withOpacity(0),
    pageBuilder: (_, __, ___) => ImageViewerPage(
      imageUrls: [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
      ],
      initialIndex: 0, // index image when user tap
      transitionStyle: ImageTransitionStyle.flip,
    ),
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
);
// For Getx navigator
Get.to(
  () => ImageViewerPage(
    imageUrls: [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
      ],
    initialIndex: 0, // index image when user tap
    transitionStyle: ImageTransitionStyle.flip,
  ),
  fullscreenDialog: true,
  opaque: false,
  transition: Transition.noTransition,
  popGesture: true,
  curve: Curves.easeInOut,
);

```

## Example

To see a full working example with grid thumbnails and different transitions:

```bash
cd example && flutter run
```

<br />
<img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/cambodia.webp" width="230" />

## Creator

<img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/ratha.jpeg" width="150" />

<hr />

**ហ៊ិន រដ្ឋា**  
Mr. Hin Ratha  
Flutter & Mobile Apps Developer  
📱 096 659 2250  
🌐 [rathadev.site](https://rathadev.site)

---

Enjoy building animated image galleries with `ImageViewerPage`!
