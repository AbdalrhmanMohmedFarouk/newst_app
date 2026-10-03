import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/datasource/remote_data/api_service.dart';
import 'package:newst_app/core/repos/news_repository.dart';
import 'package:newst_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SearchScreenController(NewsRepository(ApiService()));
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Search")),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.sizeH(20),
            horizontal: AppSizes.sizeW(16),
          ),
          child: Consumer<SearchScreenController>(
            builder:
                (BuildContext context,
                SearchScreenController controller,
                Widget? child,) {
              return Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.getEverything();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xffA0A0A0),
                        size: AppSizes.radius(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD3D3D3)),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.sizeH(20)),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.newsEverythingList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsEverythingList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.search,
                              color: Color(0xffA0A0A0),
                              size: AppSizes.radius(20),
                            ),
                            title: Text(model.title, maxLines: 1),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                          color: Color(0xFFA0A0A0)
                      );
                    },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
