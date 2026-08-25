import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/features/home/components/view_all_components.dart';
import 'package:newst_app/features/home/models/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            return SliverList.builder(
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
                      model.urlToImage != null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          model.urlToImage ?? "",
                          height: 80,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ) : SizedBox(
                        height: 80,
                        width: 140,
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
                                      if(model.urlToImage != null)
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
            );
          },
    );
  }
}
