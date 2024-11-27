import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tactix_academy_admin/Features/Authentication/Presentation/Pages/splash_screen.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Pages/screen_home.dart';
import 'package:tactix_academy_admin/Features/Licence%20Requests/Presentations/Pages/request_lists.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: ScreenHome()),
    );
  }
}
