
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/core/widgets/custom_cached_network_image.dart';
import 'package:newst_app/features/home/models/home_controller.dart';
import 'package:provider/provider.dart';

import '../../core/theme/light_color.dart';
import 'components/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories"), centerTitle: true),
      body: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: SizedBox(
                  height: 35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 12);
                    },
                    padding: EdgeInsets.only(right: 16),
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelected =
                          categories[index] == controller.selectedCategory;
                      return GestureDetector(
                        onTap: () {
                          controller.updateSelectedCategory(categories[index]);
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() +
                                    categories[index].substring(1),
                                style: TextStyle(
                                  color: Color(0xFF363636),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (isSelected) ...[
                                SizedBox(height: 6),
                                Container(
                                  height: 2,
                                  color: LightColors.primaryColor,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              //
              Expanded(
                child: ListView.builder(
                  itemCount: controller.newsTopHeadLineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = controller.newsTopHeadLineList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomCachedNetworkImage(
                              imagePath: model.urlToImage ?? "",
                            ),

                            // Image.network(
                            //   model.urlToImage ?? "",
                            //   errorBuilder:(BuildContext context, Object error, StackTrace? stackTrace){
                            //     return Container(height: 80,
                            //       width: 140,
                            //     color:Colors.red ,
                            //     );
                            //   } ,
                            //   height: 80,
                            //   width: 140,
                            //   fit: BoxFit.cover,
                            // ),
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
                                              radius: 10,
                                            ),
                                          SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              (model.author ?? "").substring(
                                                0,
                                                min(
                                                  (model.author ?? "").length,
                                                  10,
                                                ),
                                              ),
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
                                      model.publishedAt.formateDateTime(),
                                      style: TextStyle(
                                        color: Color(0xFF141414),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
