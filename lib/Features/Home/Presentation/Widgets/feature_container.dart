import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';

import 'package:tactix_academy_admin/Features/All%20Players/presentation/pages/all_players.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/pages/all_teams.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Widgets/options_card.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Widgets/settings_card.dart';
import 'package:tactix_academy_admin/Features/Home/domain/entities/home_details.dart';

class FeaturesContainer extends StatelessWidget {
  final HomeDetails details;
  final double? height;

  const FeaturesContainer({super.key, this.height, required this.details});

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  OptionsCard(
                      nextPage: const AllTeams(),
                      icon: Icons.group,
                      title: 'Teams',
                      value: details.teamCount,
                      color: Colors.blue),
                  const SizedBox(height: 12),
                  OptionsCard(
                      nextPage: AllPlayers(),
                      icon: Icons.sports_soccer,
                      title: 'Players',
                      value: details.playersCount,
                      color: Colors.green),
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
