import 'package:flutter/material.dart';
import 'package:newst_app/core/mixins/safe_notify_mixin.dart';
import 'package:newst_app/features/bookmark/bookmark_repository.dart';
import 'package:newst_app/features/bookmark/models/bookmark_model.dart';
import 'package:newst_app/features/home/models/news_article_model.dart';

class BookmarkController extends ChangeNotifier with SafeNotify {
  final BookmarkRepository _repository = BookmarkRepository();

  List<BookmarkModel> bookmarks = [];

  BookmarkController() {
    getBookmarks();
  }

  /// Loads all bookmarks from Hive.
  void getBookmarks() {
    bookmarks = _repository.getAllBookmarks();
    safeNotify();
  }

  /// Checks if an article is bookmarked.
  bool isBookmarked(NewsArticleModel article) {
    return _repository.isBookmarked(
      url: article.url,
      title: article.title,
    );
  }

  /// Toggles bookmark state for an article.
  Future<void> toggleBookmark(NewsArticleModel article) async {
    final alreadyBookmarked = isBookmarked(article);

    if (alreadyBookmarked) {
      await _repository.removeBookmark(
        url: article.url,
        title: article.title,
      );
    } else {
      await _repository.addBookmark(
        BookmarkModel.fromNewsArticle(article),
      );
    }

    getBookmarks();
  }

  /// Removes an article from bookmarks.
  Future<void> removeBookmark(NewsArticleModel article) async {
    await _repository.removeBookmark(
      url: article.url,
      title: article.title,
    );
    getBookmarks();
  }

  /// Removes a bookmark model directly.
  Future<void> removeBookmarkModel(BookmarkModel bookmark) async {
    await _repository.removeBookmark(
      url: bookmark.url,
      title: bookmark.title,
    );
    getBookmarks();
  }

  /// Clears all bookmarks.
  Future<void> clearAllBookmarks() async {
    await _repository.clearAll();
    getBookmarks();
  }
}
