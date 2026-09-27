import 'dart:math';

import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newst_app/core/enums/request_status_enum.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/core/widgets/custom_cached_network_image.dart';
import 'package:newst_app/core/widgets/custom_svg_picture.dart';
import 'package:newst_app/features/home/components/news_item.dart';
import 'package:newst_app/features/home/components/top_headline_shimmer.dart';
import 'package:newst_app/features/home/components/view_all_components.dart';
import 'package:newst_app/features/home/models/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        switch (controller.newsTopHeadLineStatus) {
          case RequestStatusEnum.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(
              child: Center(child: Text(controller.errorMessage ?? "")),
            );
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadLineList.length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.newsTopHeadLineList[index];
                return NewsItem(model: model,);
              },
            );
        }
      },
    );
  }
}
