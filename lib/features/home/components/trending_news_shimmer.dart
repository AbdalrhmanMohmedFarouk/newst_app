import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left:  AppSizes.sizeW(16)),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width:  AppSizes.sizeW(12));
      },
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height:  AppSizes.sizeH(140), width:  AppSizes.sizeW(240), color: Colors.white),
        );
      },
    );
  }
}
