import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newst_app/core/datasource/local_data/preferences_manger.dart';
import 'package:newst_app/core/datasource/local_data/user_repository.dart';
import 'package:newst_app/core/theme/light_theme.dart';
import 'package:newst_app/features/bookmark/bookmark_controller.dart';
import 'package:newst_app/features/bookmark/bookmark_repository.dart';
import 'package:newst_app/features/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManger().init();
  await UserRepository().init();
  await BookmarkRepository().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookmarkController(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 832),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
