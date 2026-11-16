import 'package:flutter/material.dart';
import 'package:newst_app/core/theme/light_color.dart';
import 'package:newst_app/features/bookmark/bookmark_controller.dart';
import 'package:newst_app/features/bookmark/bookmark_screen.dart';
import 'package:newst_app/features/home/home_screen.dart';
import 'package:newst_app/features/profile/profile_screen.dart';
import 'package:newst_app/features/search/search_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      SearchScreen(),
      BookmarkScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Consumer<BookmarkController>(
              builder: (context, controller, child) {
                if (controller.bookmarks.isEmpty) {
                  return const Icon(Icons.bookmark_border);
                }
                return Badge(
                  backgroundColor: LightColors.primaryColor,
                  label: Text(
                    controller.bookmarks.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Icon(Icons.bookmark_border),
                );
              },
            ),
            activeIcon: Consumer<BookmarkController>(
              builder: (context, controller, child) {
                if (controller.bookmarks.isEmpty) {
                  return const Icon(Icons.bookmark);
                }
                return Badge(
                  backgroundColor: LightColors.primaryColor,
                  label: Text(
                    controller.bookmarks.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Icon(Icons.bookmark),
                );
              },
            ),
            label: "Bookmark",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
