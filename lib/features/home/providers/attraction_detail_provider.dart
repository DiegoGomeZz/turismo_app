import 'package:flutter/material.dart';

class AttractionDetailProvider extends ChangeNotifier {
  final PageController pageController = PageController();

  int _currentImageIndex = 0;
  bool _isDescriptionExpanded = false;
  bool _areReviewsExpanded = false;

  int get currentImageIndex => _currentImageIndex;
  bool get isDescriptionExpanded => _isDescriptionExpanded;
  bool get areReviewsExpanded => _areReviewsExpanded;

  void onImagePageChanged(int index) {
    _currentImageIndex = index;
    notifyListeners();
  }

  void nextImage(int totalImages) {
    if (_currentImageIndex < totalImages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousImage() {
    if (_currentImageIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void toggleDescription() {
    _isDescriptionExpanded = !_isDescriptionExpanded;
    notifyListeners();
  }

  void toggleReviews() {
    _areReviewsExpanded = !_areReviewsExpanded;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
