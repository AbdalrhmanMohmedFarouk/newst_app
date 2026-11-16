import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/core/widgets/custom_cached_network_image.dart';
import 'package:newst_app/core/widgets/custom_svg_picture.dart';
import 'package:newst_app/features/bookmark/bookmark_controller.dart';
import 'package:newst_app/features/details/news_details_screen.dart';
import 'package:newst_app/features/home/models/news_article_model.dart';
import 'package:provider/provider.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});

  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return NewsDetailsScreen(model: model);
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.sizeW(16),
          vertical: AppSizes.sizeH(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radius(8)),
              child: CustomCachedNetworkImage(
                imagePath: model.urlToImage ?? "",
              ),
            ),
            SizedBox(width: AppSizes.sizeW(8)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                      fontSize: AppSizes.fontSize(16),
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (model.urlToImage != null)
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  model.urlToImage!,
                                ),
                                radius: AppSizes.radius(10),
                              ),
                            SizedBox(width: AppSizes.sizeW(6)),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    (model.author ?? "").substring(
                                      0,
                                      min((model.author ?? "").length, 10),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0xFF141414),
                                      fontSize: AppSizes.fontSize(12),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                  ),
                                  SizedBox(width: AppSizes.sizeW(8)),
                                  Text(
                                    model.publishedAt.formateDateTime(),
                                    style: TextStyle(
                                      color: const Color(0xFF141414),
                                      fontSize: AppSizes.fontSize(14),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<BookmarkController>(
                        builder: (context, bookmarkController, child) {
                          final isBookmarked =
                              bookmarkController.isBookmarked(model);
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              final wasBookmarked = isBookmarked;
                              await bookmarkController.toggleBookmark(model);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      wasBookmarked
                                          ? "Removed from bookmarks"
                                          : "Saved to bookmarks",
                                    ),
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.sizeW(4),
                              ),
                              child: isBookmarked
                                  ? Icon(
                                      Icons.bookmark,
                                      color: LightColors.primaryColor,
                                      size: AppSizes.sizeH(20),
                                    )
                                  : const CustomSvgPicture.withoutColor(
                                      path: "assets/svg/bockmark.svg",
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
