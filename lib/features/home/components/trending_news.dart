import 'package:flutter/material.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/features/home/models/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                      SizedBox(height: 6),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "View all",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFFFCFC),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFFFFCFC),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                          return (controller.errorMessage?.isNotEmpty ?? false)
                              ? Center(child: Text(controller.errorMessage!))
                              : controller.everythingLoading
                              ? Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.newsEverythingList.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return SizedBox(width: 12);
                                      },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Stack(
                                            children: [
                                              if (controller
                                                      .newsEverythingList[index]
                                                      .urlToImage !=
                                                  null)
                                                Image.network(
                                                  controller
                                                      .newsEverythingList[index]
                                                      .urlToImage!,
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                );
                        },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
