import 'package:flutter/material.dart';
import 'package:newst_app/core/constants/app_sizes.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/features/bookmark/bookmark_controller.dart';
import 'package:newst_app/features/home/components/news_item.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarkController>().getBookmarks();
    });
  }

  void _showClearAllDialog(
    BuildContext context,
    BookmarkController controller,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Clear all bookmarks?"),
          content: const Text(
            "All saved articles will be removed from your bookmarks.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                controller.clearAllBookmarks();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All bookmarks cleared"),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                "Clear All",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<BookmarkController>(
          builder: (context, controller, child) {
            return Text(
              controller.bookmarks.isEmpty
                  ? "Bookmark"
                  : "Bookmark (${controller.bookmarks.length})",
            );
          },
        ),
        actions: [
          Consumer<BookmarkController>(
            builder: (context, controller, child) {
              if (controller.bookmarks.isEmpty) return const SizedBox();
              return IconButton(
                tooltip: "Clear All",
                icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: () {
                  _showClearAllDialog(context, controller);
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<BookmarkController>(
        builder: (context, controller, child) {
          if (controller.bookmarks.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW(32)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: AppSizes.sizeW(100),
                      height: AppSizes.sizeH(100),
                      decoration: BoxDecoration(
                        color: LightColors.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.bookmark_outline_rounded,
                        size: AppSizes.sizeH(50),
                        color: LightColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: AppSizes.sizeH(24)),
                    Text(
                      "No Bookmarks Yet",
                      style: TextStyle(
                        fontSize: AppSizes.fontSize(20),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF141414),
                      ),
                    ),
                    SizedBox(height: AppSizes.sizeH(8)),
                    Text(
                      "Articles you bookmark will be saved here for quick reading anytime.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppSizes.fontSize(14),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6E7191),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.bookmarks.length,
            padding: EdgeInsets.symmetric(vertical: AppSizes.sizeH(8)),
            itemBuilder: (context, index) {
              final bookmark = controller.bookmarks[index];
              return Dismissible(
                key: Key(bookmark.url ?? "${bookmark.title}_$index"),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW(20)),
                  color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 26,
                      ),
                      SizedBox(width: AppSizes.sizeW(6)),
                      Text(
                        "Remove",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.fontSize(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onDismissed: (_) {
                  final removedArticle = bookmark.toNewsArticle();
                  controller.removeBookmarkModel(bookmark);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Bookmark removed"),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: () {
                          controller.toggleBookmark(removedArticle);
                        },
                      ),
                    ),
                  );
                },
                child: NewsItem(model: bookmark.toNewsArticle()),
              );
            },
          );
        },
      ),
    );
  }
}
