import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newst_app/features/home/components/categories_list.dart';
import 'package:newst_app/features/home/components/trending_news.dart';
import 'package:newst_app/features/home/components/view_all_components.dart';

import 'package:newst_app/features/home/models/home_controller.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                TrendingNews(),
                SliverToBoxAdapter(
                  child: ViewAllComponents(
                    title: "Category",
                    titleColor: Color(0xFF141414),
                    onTap: () {},
                  ),
                ),
                CategoriesList(),
                SliverList.builder(
                  itemCount: controller.newsTopHeadLineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = controller.newsTopHeadLineList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal:16,vertical: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(model.urlToImage ?? "",height: 80,width: 140,fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: .spaceBetween,
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  model.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  maxLines: 2,
                                ),
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
                                              (model.author ?? "").substring(0, min((model.author ?? "").length, 10)),
                                              style: TextStyle(
                                                color: Color(0xFF141414),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      formateDateTime(
                                        model.publishedAt,
                                      ),
                                      style: TextStyle(
                                        color: Color(
                                          0xFF141414,
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
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
