import 'package:flutter/cupertino.dart';
import 'package:newst_app/core/enums/request_status_enum.dart';
import 'package:newst_app/core/mixins/safe_notify_mixin.dart';
import 'package:newst_app/core/repos/news_repository.dart';
import 'package:newst_app/features/home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotify {
  TextEditingController searchController = TextEditingController();

  SearchScreenController(this.newsRepository);
  final BaseNewsRepository newsRepository;

  List<NewsArticleModel> newsEverythingList = [];
  String? errorMessage ;
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;


Future<void> getEverything() async {
  try {
    newsEverythingList = await newsRepository.getEverything(query : searchController.text );
    everythingStatus = RequestStatusEnum.loaded;
    errorMessage = null;
  } catch (e) {
    everythingStatus = RequestStatusEnum.error;
    errorMessage = e.toString();
  }

  safeNotify();
}


}


