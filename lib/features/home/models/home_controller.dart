import 'package:flutter/material.dart';
import 'package:newst_app/core/enums/request_status_enum.dart';
import 'package:newst_app/core/mixins/safe_notify_mixin.dart';
import 'package:newst_app/core/repos/news_repository.dart';
import 'news_article_model.dart';

class HomeController extends ChangeNotifier with SafeNotify{
  String? errorMessage;

  List<NewsArticleModel> newsTopHeadLineList = [];

  List<NewsArticleModel> newsEverythingList = [];

  final BaseNewsRepository newsRepository;

  String? selectedCategory;


  HomeController(this.newsRepository) {
    getEverything();
    getTopHeadLine();
  }

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum newsTopHeadLineStatus = RequestStatusEnum.loading;

  Future<void> getTopHeadLine({String? category}) async {
    try {
      newsTopHeadLineStatus = RequestStatusEnum.loading;
      safeNotify();

      newsTopHeadLineList = await newsRepository.getTopHeadLine(
        selectedCategory: selectedCategory,
      );

      newsTopHeadLineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      newsTopHeadLineStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
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
    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    safeNotify();
  }


}
