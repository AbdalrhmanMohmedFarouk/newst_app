import 'package:hive_ce_flutter/adapters.dart';
import 'package:newst_app/core/constants/constants.dart';
import 'package:newst_app/features/bookmark/models/bookmark_model.dart';
import 'package:newst_app/features/home/models/news_article_model.dart';

class BookmarkRepository {
  static final BookmarkRepository _instance = BookmarkRepository._();

  BookmarkRepository._();

  factory BookmarkRepository() => _instance;

  Box<BookmarkModel>? _box;

  Box<BookmarkModel> get _bookmarkBox {
    if (_box == null) {
      throw Exception(
          "BookmarkRepository not initialized. Call init() first.");
    }
    return _box!;
  }

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookmarkModelAdapter());
    }
    _box = await Hive.openBox<BookmarkModel>(Constants.bookmarkBox);
  }

  String _getKey(String? url, String title) {
    return (url != null && url.isNotEmpty) ? url : title;
  }

  /// Adds a bookmark.
  Future<void> addBookmark(BookmarkModel bookmark) async {
    final key = _getKey(bookmark.url, bookmark.title);
    await _bookmarkBox.put(key, bookmark);
  }

  /// Removes a bookmark by article url or title.
  Future<void> removeBookmark({String? url, required String title}) async {
    final key = _getKey(url, title);
    await _bookmarkBox.delete(key);
  }

  /// Returns all bookmarks.
  List<BookmarkModel> getAllBookmarks() {
    return _bookmarkBox.values.toList();
  }

  /// Checks if an article is bookmarked.
  bool isBookmarked({String? url, required String title}) {
    final key = _getKey(url, title);
    return _bookmarkBox.containsKey(key);
  }

  /// Clears all bookmarks.
  Future<void> clearAll() async {
    await _bookmarkBox.clear();
  }
}
