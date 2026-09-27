import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadlineShimmer extends StatelessWidget {
  const TopHeadlineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:  EdgeInsets.all( AppSizes.sizeW(16)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height:  AppSizes.sizeH(80),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}