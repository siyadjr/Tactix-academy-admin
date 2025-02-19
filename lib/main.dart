import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:tactix_academy_admin/Core/Constants/di/service_locator.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/Pages/splash_screen.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/bloc/authentications_bloc.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/bloc/home_screen_datas_bloc.dart';
import 'package:tactix_academy_admin/Features/All%20Players/presentation/bloc/players_bloc_bloc.dart';

import 'package:tactix_academy_admin/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => sl<AuthBloc>(),
            ),
            BlocProvider<HomeScreenDatasBloc>(
              create: (context) => sl<HomeScreenDatasBloc>(),
            ),
            BlocProvider<PlayersBloc>(
              create: (context) => sl<PlayersBloc>(),
            ),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
