// Flutter material package for UI widgets
import 'package:flutter/material.dart';
// Dart math package for rotation calculations
import 'dart:math';

/// Enum for defining different image transition animations
enum ImageTransitionStyle {
  slide,
  fade,
  scale,
  flip,
  rotate,
  cube,
}

/// ImageViewerPage widget with zoom, swipe-to-dismiss, and animated transitions
class ImageViewerPage extends StatefulWidget {
  final List<String> imageUrls; // List of image URLs to display
  final int initialIndex; // Initially selected image index
  final ImageTransitionStyle transitionStyle; // Animation style between pages

  const ImageViewerPage({
    Key? key,
    required this.imageUrls,
    required this.initialIndex,
    this.transitionStyle = ImageTransitionStyle.slide,
  }) : super(key: key);

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController; // Controls the PageView
  late List<TransformationController>
      _transformationControllers; // For zoom control
  late AnimationController _resetAnimationController; // Animates reset zoom
  Animation<Matrix4>? _animation; // Matrix animation for zoom reset

  int currentIndex = 0; // Current index of viewed image
  Offset _dragOffset = Offset.zero; // Vertical drag offset
  double _opacity = 1.0; // Background opacity for swipe-to-dismiss
  bool _isZoomed = false; // Whether current image is zoomed in

  // Zoom constraints
  final double _minScaleLimit = 1.0;
  final double _maxScaleLimit = 4.5;
  final double _hardMinScale = 0.1;
  final double _hardMaxScale = 10.0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);

    // Initialize transformation controllers for each image
    _transformationControllers = List.generate(
      widget.imageUrls.length,
      (_) => TransformationController()..value = Matrix4.identity(),
    );

    _transformationControllers[currentIndex].addListener(_onScaleChange);

    // Setup animation controller for zoom reset
    _resetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Apply animated matrix to controller during reset
    _resetAnimationController.addListener(() {
      _transformationControllers[currentIndex].value = _animation!.value;
    });
  }

  @override
  void dispose() {
    // Clean up controllers and listeners
    for (var controller in _transformationControllers) {
      controller.removeListener(_onScaleChange);
      controller.dispose();
    }
    _resetAnimationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Detect zoom level and update state
  void _onScaleChange() {
    final scale =
        _transformationControllers[currentIndex].value.getMaxScaleOnAxis();
    final zoomed = scale > 1.2;
    if (zoomed != _isZoomed) {
      setState(() => _isZoomed = zoomed);
    }
  }

  // Update drag offset during swipe
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_isZoomed) return; // Don't allow dismiss if zoomed

    setState(() {
      _dragOffset += Offset(0, details.delta.dy);
      _dragOffset = Offset(0, _dragOffset.dy.clamp(-300, 300));
      _opacity = (1 - _dragOffset.dy.abs() / 300).clamp(0.0, 1.0);
    });
  }

  // Handle swipe end: dismiss or reset
  void _onVerticalDragEnd(DragEndDetails details) {
    final scale =
        _transformationControllers[currentIndex].value.getMaxScaleOnAxis();

    if (_dragOffset.dy.abs() > 150 && scale <= _minScaleLimit + 0.01) {
      Navigator.of(context).pop(); // Dismiss image viewer
    } else {
      setState(() {
        _dragOffset = Offset.zero;
        _opacity = 1.0;
      });
    }
  }

  // Animate to a target matrix (used for zoom reset or double-tap zoom)
  void _animateToMatrix(Matrix4 targetMatrix) {
    final controller = _transformationControllers[currentIndex];
    final begin = controller.value;

    _animation = Matrix4Tween(begin: begin, end: targetMatrix).animate(
      CurvedAnimation(
        parent: _resetAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _resetAnimationController.forward(from: 0);
  }

  // Correct scale if it's out of allowed limits
  void _checkAndCorrectScale() {
    final controller = _transformationControllers[currentIndex];
    final currentMatrix = controller.value;
    final currentScale = currentMatrix.getMaxScaleOnAxis();

    if (currentScale < _minScaleLimit || currentScale > _maxScaleLimit) {
      final scaleFactor = currentScale < _minScaleLimit
          ? _minScaleLimit / currentScale
          : _maxScaleLimit / currentScale;

      final Matrix4 newMatrix = currentMatrix.clone()..scale(scaleFactor);
      _animateToMatrix(newMatrix);
    }
  }

  // Builds a zoomable, double-tap zoomable image with Hero support
  Widget _buildTransformedImage(int index) {
    return Center(
      child: GestureDetector(
        onDoubleTapDown: (details) {
          final tapPosition = details.localPosition;
          final controller = _transformationControllers[index];
          final currentScale = controller.value.getMaxScaleOnAxis();

          if (currentScale > 1.1) {
            _animateToMatrix(Matrix4.identity()); // Reset zoom
          } else {
            const zoomScale = 2.0;
            final double x = -tapPosition.dx * (zoomScale - 1);
            final double y = -tapPosition.dy * (zoomScale - 1);

            final matrix = Matrix4.identity()
              ..translate(x, y)
              ..scale(zoomScale);

            _animateToMatrix(matrix); // Zoom in to tap position
          }
        },
        onScaleEnd: (_) => _checkAndCorrectScale(),
        child: InteractiveViewer(
          transformationController: _transformationControllers[index],
          panEnabled: true,
          scaleEnabled: true,
          minScale: _hardMinScale,
          maxScale: _hardMaxScale,
          clipBehavior: Clip.none,
          child: Hero(
            tag: widget.imageUrls[index],
            child: Image.network(
              widget.imageUrls[index],
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

  // Builds a page with optional transition animation
  Widget _buildAnimatedPage(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
        }
        final absValue = value.abs().clamp(0.0, 1.0);
        Widget transformedChild = _buildTransformedImage(index);

        // Apply different animation styles
        switch (widget.transitionStyle) {
          case ImageTransitionStyle.fade:
            return Opacity(
              opacity: 1.0 - absValue,
              child: transformedChild,
            );
          case ImageTransitionStyle.scale:
            return Transform(
              transform: Matrix4.identity()
                ..scale(1.0 - absValue * 0.5, 1.0 - absValue * 0.5),
              alignment: Alignment.center,
              child: transformedChild,
            );
          case ImageTransitionStyle.flip:
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi * value),
              child: transformedChild,
            );
          case ImageTransitionStyle.rotate:
            return Transform.rotate(
              angle: (pi * value) / 2,
              child: transformedChild,
            );
          case ImageTransitionStyle.cube:
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(pi / 2 * value),
              alignment: Alignment.center,
              child: transformedChild,
            );
          case ImageTransitionStyle.slide:
          default:
            return transformedChild; // No animation
        }
      },
    );
  }

  // Main UI layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(_opacity),
      body: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: Stack(
          children: [
            // Main image pager with animation and zoom
            Transform.translate(
              offset: _dragOffset,
              child: PageView.builder(
                controller: _pageController,
                physics: _isZoomed
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                itemCount: widget.imageUrls.length,
                onPageChanged: (index) {
                  _transformationControllers[currentIndex]
                      .removeListener(_onScaleChange);

                  setState(() {
                    currentIndex = index;
                    _dragOffset = Offset.zero;
                    _opacity = 1.0;
                    _isZoomed = false;
                  });

                  _transformationControllers[currentIndex]
                      .addListener(_onScaleChange);
                },
                itemBuilder: (context, index) => _buildAnimatedPage(index),
              ),
            ),
            // Close button
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child: Opacity(
                opacity: _opacity,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            // Page indicator (if multiple images)
            if (widget.imageUrls.length > 1)
              Positioned(
                top: MediaQuery.of(context).padding.top + 30,
                left: 16,
                child: Opacity(
                  opacity: _opacity,
                  child: Text(
                    "${currentIndex + 1}/${widget.imageUrls.length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
