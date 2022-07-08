import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui_test/pages/homepage.dart';
import 'package:flutter_ui_test/utils/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 686),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (builder, context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: bgDefaultColor,
              primarySwatch: Colors.blue,
              fontFamily: 'Satoshi',
            ),
            home: Homepage(),
          );
        });
  }
}
