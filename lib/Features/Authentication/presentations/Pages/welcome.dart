import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Core/Widgets/custom_widgets.dart';
import 'package:tactix_academy_admin/Core/services/notification_service.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/bloc/authentications_bloc.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/bloc/authentications_event.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/bloc/authentications_state.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Pages/screen_home.dart';

class WelcomePage extends StatelessWidget {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          if (context.mounted) {
            AppSnackBar.showSuccess(context, 'Signed in successfully');
            NotificationService().updateAdminFcmToken();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (ctx) => const ScreenHome()),
            );
          }
        } else if (state is AuthFailure) {
          AppSnackBar.showError(context, 'Invalid credentials. Please try again.');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Row(
            children: [
              // Left Side: Branding (Visible only on Web/Desktop)
              if (size.width > 800)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [kBackgroundColor, kPrimaryColor.withOpacity(0.1)],
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: kPrimaryColor.withOpacity(0.2)),
                              ),
                              child: const Icon(Icons.shield_rounded, size: 64, color: kPrimaryColor),
                            ),
                            const SizedBox(height: 32),
                            const Text(
                              'Tactix Academy',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: kTextColorPrimary,
                                letterSpacing: -1,
                              ),
                            ),
                            const Text(
                              'Administration Hub',
                              style: TextStyle(
                                fontSize: 24,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Manage your academy, players, and operations with our sleek, high-performance dashboard.',
                              style: TextStyle(
                                fontSize: 16,
                                color: kTextColorSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Right Side: Login Form
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 450),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Show Logo only on Mobile
                            if (size.width <= 800) ...[
                              const Center(
                                child: Icon(Icons.shield_rounded, size: 64, color: kPrimaryColor),
                              ),
                              const SizedBox(height: 24),
                              const Center(
                                child: Text(
                                  'Tactix Academy',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColorPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 48),
                            ],

                            const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: kTextColorPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Enter your credentials to access the admin portal',
                              style: TextStyle(
                                fontSize: 16,
                                color: kTextColorSecondary,
                              ),
                            ),
                            const SizedBox(height: 40),

                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  AppTextField(
                                    controller: mailController,
                                    label: 'Username',
                                    hint: 'e.g., admin@tactix',
                                    prefixIcon: Icons.person_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your username';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                  AppTextField(
                                    controller: passwordController,
                                    label: 'Password',
                                    hint: '••••••••',
                                    prefixIcon: Icons.lock_outline,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                  AppButton(
                                    text: 'Sign In to Dashboard',
                                    isLoading: state is AuthLoading,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                          LoginEvent(
                                            mailController.text,
                                            passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 40),
                            const Center(
                              child: Text(
                                '© 2025 Tactix Academy. Built for Performance.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kTextColorSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
