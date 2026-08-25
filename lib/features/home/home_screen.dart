import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newst_app/core/extensions/data_time_extension.dart';
import 'package:newst_app/features/home/components/categories_list.dart';
import 'package:newst_app/features/home/components/top_headLine.dart';
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
                CategoriesList(),
                TopHeadline(),
              ],
            ),
          );
        },
      ),
    );
  }
}
