# ImageViewerPage

[ImageViewerPage](https://pub.dev/packages/image_viewer_page) ជួយអ្នកបង្ហាញរូបភាពជាស្រឡាយ និងអាចធ្វើចលនាប្លង់ចេញចូល (transitions) ដូចជា: flip, fade, rotate, scale និង cube!

[ImageViewerPage](https://pub.dev/packages/image_viewer_page) helps you create beautiful full-screen image viewers with gesture control, zoom, swipe-to-dismiss, and animated transitions.

<hr />
<p align="center">
  <img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/thumbnail.gif"/>
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

## Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  image_viewer_page: ^1.0.0
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
ImageViewerPage(
  imageUrls: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
  ],
  initialIndex: 0,
  transitionStyle: ImageTransitionStyle.flip,
);
```

## Features

✅ Pinch to zoom  
 <img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/pinch_zoom.gif"/>
✅ Double tap to zoom  
 <img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/touble_tap_zoom.gif"/>
✅ Swipe to dismiss  
 <img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/dismiss.gif"/>
✅ Transition styles:

- `slide`
- `fade`
- `scale`
- `flip`
- `rotate`
- `cube`
  <img src="https://raw.githubusercontent.com/RathaIct/ImageViewerPage/main/images/transition.gif"/>

✅ Page indicator overlay  
✅ Hero animation support

## Example

To see a full working example with grid thumbnails and different transitions:

```bash
cd example && flutter run
```

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
