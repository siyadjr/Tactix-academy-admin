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
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: logoSize,
              height: logoSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splashPhoto.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'TACTIX ACADEMY',
              style: TextStyle(
                color: kTextColorPrimary,
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: kSurfaceColor,
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
