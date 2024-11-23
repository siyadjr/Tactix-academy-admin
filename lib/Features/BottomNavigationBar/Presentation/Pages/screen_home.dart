import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/BottomNavigationBar/Presentation/Widgets/app_bar.dart';
import 'package:tactix_academy_admin/Features/BottomNavigationBar/Presentation/Widgets/feature_container.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Check if the screen width is large enough (e.g., typical web width)
          bool isWebLayout = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: isWebLayout
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photo Container on the left
                        Container(
                          width: constraints.maxWidth * 0.5,
                          height: constraints.maxWidth * 0.5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/boss.png'), // Corrected asset path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Widgets on the right
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Appbar(),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Boss',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              FeaturesContainer(
                                height: constraints.maxWidth * 0.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Appbar(),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Boss',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * 0.8,
                          height: constraints.maxWidth * 0.8,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/boss.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const FeaturesContainer(),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
