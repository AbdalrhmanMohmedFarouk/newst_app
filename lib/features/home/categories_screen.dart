import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/features/home/components/news_item.dart';
import 'package:newst_app/features/home/models/home_controller.dart';
import 'package:provider/provider.dart';

import '../../core/theme/light_color.dart';
import 'components/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(AppSizes.sizeW(16),
                  AppSizes.sizeH(16),
                  0,
                  AppSizes.sizeH(16),),
                child: SizedBox(
                  height:  AppSizes.sizeH(35),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width:  AppSizes.sizeW(12));
                    },
                    padding: EdgeInsets.only(right:  AppSizes.sizeW(12)),
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
                                  fontSize:  AppSizes.fontSize(16),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (isSelected) ...[
                                SizedBox(height:  AppSizes.sizeH(6)),
                                Container(
                                  height:  AppSizes.sizeH(2),
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
                    return NewsItem(model: model);
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
