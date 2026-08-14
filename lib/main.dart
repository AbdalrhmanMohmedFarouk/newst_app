import 'package:flutter/material.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/core/theme/light_theme.dart';

import 'package:newst_app/features/splash/splash_screen.dart';

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
      home: SplashScreen(),
    );
  }
}
