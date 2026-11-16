import 'dart:math';
import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/core/widgets/custom_cached_network_image.dart';
import 'package:newst_app/core/widgets/custom_svg_picture.dart';
import 'package:newst_app/features/bookmark/bookmark_controller.dart';
import 'package:newst_app/features/home/models/news_article_model.dart';
import 'package:provider/provider.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});

  final NewsArticleModel model;

  Future<void> _handleToggle(
    BuildContext context,
    BookmarkController controller,
    bool isBookmarked,
  ) async {
    final wasBookmarked = isBookmarked;
    await controller.toggleBookmark(model);
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasBookmarked ? "Removed from bookmarks" : "Saved to bookmarks",
          ),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
        actions: [
          Consumer<BookmarkController>(
            builder: (context, bookmarkController, child) {
              final isBookmarked = bookmarkController.isBookmarked(model);
              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked
                      ? LightColors.primaryColor
                      : const Color(0xFF141414),
                ),
                onPressed: () =>
                    _handleToggle(context, bookmarkController, isBookmarked),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.sizeH(8)),
          child: Column(
            children: [
              SizedBox(height: AppSizes.sizeH(20)),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radius(16)),
                child: CustomCachedNetworkImage(
                  imagePath: model.urlToImage ?? "",
                  width: double.infinity,
                  height: AppSizes.sizeH(200),
                ),
              ),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: AppSizes.fontSize(20),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF141414),
                ),
              ),
              SizedBox(height: AppSizes.sizeH(8)),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (model.urlToImage != null)
                          CircleAvatar(
                            backgroundImage: NetworkImage(model.urlToImage!),
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
                              SizedBox(width: AppSizes.sizeW(16)),
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
                        onTap: () => _handleToggle(
                          context,
                          bookmarkController,
                          isBookmarked,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppSizes.sizeW(4)),
                          child: isBookmarked
                              ? Icon(
                                  Icons.bookmark,
                                  color: LightColors.primaryColor,
                                  size: AppSizes.sizeH(24),
                                )
                              : const CustomSvgPicture.withoutColor(
                                  path: "assets/svg/bockmark.svg",
                                  width: 24,
                                  height: 24,
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: AppSizes.sizeH(16)),
              Text(
                model.description ?? "",
                style: TextStyle(
                  color: const Color(0xFF363636),
                  fontSize: AppSizes.fontSize(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
