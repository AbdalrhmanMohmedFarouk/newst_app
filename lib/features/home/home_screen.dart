import 'package:flutter/material.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/features/home/components/trending_news.dart';

import 'package:newst_app/features/home/models/home_controller.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(body: Column(children: [TrendingNews()]));
        },
      ),
    );
  }
}

//Abdalrhman@gmail.com
//01551167826abdoAB#
