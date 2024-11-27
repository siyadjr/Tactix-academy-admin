import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Constants/appcolour.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Widgets/options_card.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Widgets/settings_card.dart';
import 'package:tactix_academy_admin/Features/Licence%20Requests/Presentations/Pages/request_lists.dart';

class FeaturesContainer extends StatelessWidget {
  final double? height;

  const FeaturesContainer({
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double containerHeight =
        height ?? MediaQuery.of(context).size.width * 1.2;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: containerHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Theme.of(context).primaryColor,
            textColor,
            textColor.withOpacity(0.8),
            Colors.black87,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const OptionsCard(
                      nextPage: RequestLists(),
                      icon: Icons.group,
                      title: 'Teams',
                      value: '21',
                      color: Colors.blue),
                  const SizedBox(height: 12),
                  const OptionsCard(
                      nextPage: RequestLists(),
                      icon: Icons.sports_soccer,
                      title: 'Players',
                      value: '85',
                      color: Colors.green),
                  const SizedBox(height: 12),
                  const OptionsCard(
                      nextPage: RequestLists(),
                      icon: Icons.person,
                      title: 'Managers',
                      value: '21',
                      color: Colors.orange),
                  const SizedBox(height: 12),
                  SettingsCard(context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
