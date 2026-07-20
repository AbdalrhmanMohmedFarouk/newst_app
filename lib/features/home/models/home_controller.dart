import 'package:flutter/material.dart';

import '../../../core/datasource/remote_data/api_config.dart';
import '../../../core/datasource/remote_data/api_service.dart';
import 'news_article_model.dart';

class HomeController extends ChangeNotifier {
  bool topHeadLineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;

  List<NewsArticleModel> newsTopHeadLineList = [];

  List<NewsArticleModel> newsEverythingList = [];

  ApiService apiService = ApiService();

  HomeController() {
    getEverything();
    getTopHeadLine();
  }

  Future<void> getTopHeadLine() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us"},
      );

      newsTopHeadLineList = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadLineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadLineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> getEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        params: {"q": "news"},
      );

      newsEverythingList = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
