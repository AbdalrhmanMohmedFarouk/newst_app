import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/core/widgets/custom_cached_network_image.dart';
import 'package:newst_app/core/widgets/custom_svg_picture.dart';
import 'package:newst_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});

  final NewsArticleModel model ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal:  AppSizes.sizeW(16),
        vertical:  AppSizes.sizeH(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular( AppSizes.radius(8)),
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
          SizedBox(width:  AppSizes.sizeW(8)),
          Expanded(
            child: Column(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Text(
                  model.title,
                  style: TextStyle(
                    fontSize:  AppSizes.fontSize(16),
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
                              radius:  AppSizes.radius(10),
                            ),
                          SizedBox(width:  AppSizes.sizeW(6)),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  (model.author ?? "").substring(
                                    0,
                                    min(
                                      (model.author ?? "").length,
                                      10,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF141414),
                                    fontSize:  AppSizes.fontSize(12),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                ),
                                SizedBox(width:  AppSizes.sizeW(8)),
                                Text(
                                  model.publishedAt
                                      .formateDateTime(),
                                  style: TextStyle(
                                    color: Color(0xFF141414),
                                    fontSize:  AppSizes.fontSize(14),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSvgPicture.withoutColor(path: "assets/svg/Icon.svg"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
