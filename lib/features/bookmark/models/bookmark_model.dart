import 'package:hive_ce_flutter/adapters.dart';
import 'package:newst_app/features/home/models/news_article_model.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 1)
class BookmarkModel {
  @HiveField(0)
  final String? author;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? url;

  @HiveField(4)
  final String? urlToImage;

  @HiveField(5)
  final int publishedAtMs;

  @HiveField(6)
  final String? content;

  BookmarkModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required DateTime publishedAt,
    required this.content,
  }) : publishedAtMs = publishedAt.millisecondsSinceEpoch;

  BookmarkModel._hive({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAtMs,
    required this.content,
  });

  DateTime get publishedAt =>
      DateTime.fromMillisecondsSinceEpoch(publishedAtMs);

  factory BookmarkModel.fromNewsArticle(NewsArticleModel article) {
    return BookmarkModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
    );
  }

  NewsArticleModel toNewsArticle() {
    return NewsArticleModel(
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
