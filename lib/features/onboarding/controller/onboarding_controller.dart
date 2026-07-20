import 'package:flutter/widgets.dart';

class OnboardingController extends ChangeNotifier {
  int currentIndex = 0;

  bool isLastPage = false;
  PageController pageController = PageController();

  void onPageChange(int index) {
    currentIndex = index;
    if (index == 2) {
      isLastPage = true;
    }else{
      isLastPage = false;
    }
    notifyListeners();
  }
}
