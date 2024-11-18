import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/BottomNavigationBar/Presentation/Widgets/welcome.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(child: SingleChildScrollView(child: Welcome())),
      ),
    );
  }
}
