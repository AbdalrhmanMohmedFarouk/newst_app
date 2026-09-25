import 'package:flutter/material.dart';
import 'package:newst_app/core/enums/request_status_enum.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/core/widgets/custom_cached_network_image.dart';
import 'package:newst_app/features/home/categories_screen.dart';
import 'package:newst_app/features/home/components/trending_news_shimmer.dart';
import 'package:newst_app/features/home/components/view_all_components.dart';
import 'package:newst_app/features/home/models/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  String formateDateTime(String? data) {
    if (data == null) return "";

    final diff = DateTime.now().difference(DateTime.parse(data));

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    }
    if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    }
    return "${diff.inDays}d ago";
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 334,
        child: Stack(
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: 70,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: LightColors.primaryColor,
                    ),
                  ),
                  ViewAllComponents(title: "Trending News", onTap: () {CategoriesScreen();}),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: Consumer<HomeController>(
                      builder:
                          (
                            BuildContext context,
                            HomeController controller,
                            Widget? child,
                          ) {
                            switch (controller.everythingStatus) {
                              case RequestStatusEnum.loading:
                                return TrendingNewsShimmer();
                              case RequestStatusEnum.error:
                                return Center(
                                  child: Text(controller.errorMessage!),
                                );
                              case RequestStatusEnum.loaded:
                                return ListView.separated(
                                  padding: EdgeInsets.only(left: 16),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.newsEverythingList
                                      .take(6)
                                      .length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return SizedBox(width: 12);
                                      },
                                  itemBuilder: (BuildContext context, int index) {
                                    final model =
                                        controller.newsEverythingList[index];
                                    return SizedBox(
                                      width: 240,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Stack(
                                          children: [
                                            CustomCachedNetworkImage(
                                              width: 240,
                                              height: 140,
                                              imagePath: model.urlToImage ?? "",
                                            ),
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.black.withValues(
                                                        alpha: 0.5,
                                                      ),
                                                      Colors.black.withValues(
                                                        alpha: 0.7,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 12,
                                              right: 12,
                                              left: 12,
                                              child: Column(
                                                crossAxisAlignment: .start,
                                                children: [
                                                  Text(
                                                    model.title,
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFCFC),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(height: 6),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                    model
                                                                        .urlToImage
                                                                        .toString(),
                                                                  ),
                                                              radius: 10,
                                                            ),
                                                            SizedBox(width: 6),
                                                            Expanded(
                                                              child: Text(
                                                                model.author ??
                                                                    "",
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xFFFFFCFC,
                                                                  ),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        model.publishedAt
                                                            .formateDateTime(),
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xFFFFFCFC,
                                                          ),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
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
                                  },
                                );
                            }
                          },
                    ),
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
