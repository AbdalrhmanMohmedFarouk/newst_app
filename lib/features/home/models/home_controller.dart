import 'package:flutter/material.dart';
import 'package:newst_app/core/enums/request_status_enum.dart';
import 'package:newst_app/features/home/repos/news_repository.dart';
import 'news_article_model.dart';

class HomeController extends ChangeNotifier {
  String? errorMessage;

  List<NewsArticleModel> newsTopHeadLineList = [];

  List<NewsArticleModel> newsEverythingList = [];

  final BaseNewsRepository newsRepository;

  String? selectedCategory;
  bool isDispose = false;

  HomeController(this.newsRepository) {
    getEverything();
    getTopHeadLine();
  }

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum newsTopHeadLineStatus = RequestStatusEnum.loading;

  Future<void> getTopHeadLine({String? category}) async {
    try {
      newsTopHeadLineStatus = RequestStatusEnum.loading;
      notify();

      newsTopHeadLineList = await newsRepository.getTopHeadLine(
        selectedCategory: selectedCategory,
      );

      newsTopHeadLineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      newsTopHeadLineStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notify();
  }

  Future<void> getEverything() async {
    try {
      newsEverythingList = await newsRepository.getEverything();
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    notify();
  }

  void notify() {
    if (!isDispose) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}
