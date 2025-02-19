import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/Pages/sign_in.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Handle navigationz
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    });

    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate responsive dimensions
    final double logoSize = screenSize.width < 600
        ? screenSize.width * 0.5
        : 300.0; // Cap size for larger screens

    final double fontSize = screenSize.width < 600 ? 20.sp : 24.sp;

    return Scaffold(
      backgroundColor: splashColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/splashPhoto.png'),
                    fit: BoxFit.contain,
                    onError: (exception, stackTrace) {
                      debugPrint('Error loading splash image: $exception');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tactix Boss',
                style: TextStyle(
                  color: secondarySplash,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(secondarySplash),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
