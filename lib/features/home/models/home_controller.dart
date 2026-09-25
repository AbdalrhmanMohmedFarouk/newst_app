import 'package:flutter/material.dart';
import 'package:newst_app/core/enums/request_status_enum.dart';
import '../../../core/datasource/remote_data/api_config.dart';
import '../../../core/datasource/remote_data/api_service.dart';
import 'news_article_model.dart';

class HomeController extends ChangeNotifier {


  String? errorMessage;

  List<NewsArticleModel> newsTopHeadLineList = [];

  List<NewsArticleModel> newsEverythingList = [];

  ApiService apiService = ApiService();
  String? selectedCategory;

  HomeController() {
    getEverything();
    getTopHeadLine();
  }

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum newsTopHeadLineStatus = RequestStatusEnum.loading;

  Future<void> getTopHeadLine({String? category}) async {
    try {
       newsTopHeadLineStatus = RequestStatusEnum.loading;
       notifyListeners();
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us", "category": selectedCategory},
      );

      newsTopHeadLineList = (result["articles"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      newsTopHeadLineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      newsTopHeadLineStatus = RequestStatusEnum.error;
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
      everythingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    notifyListeners();
  }
}
