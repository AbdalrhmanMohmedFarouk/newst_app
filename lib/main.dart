import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/core/theme/light_theme.dart';

import 'package:newst_app/features/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManger().init();
  // PreferencesManger().clear();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      home: ScreenUtilInit(
        designSize: Size(375, 832),
        minTextAdapt: true,
        builder: (ctx,_){
          return SplashScreen();
        },
      )
    );
  }
}
