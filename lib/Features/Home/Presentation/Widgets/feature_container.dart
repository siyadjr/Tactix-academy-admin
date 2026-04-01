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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.dashboard_rounded,
                      color: kPrimaryColor, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    color: kTextColorPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            OptionsCard(
              nextPage: const AllTeams(),
              icon: Icons.groups_rounded,
              title: 'Team Management',
              value: details.teamCount,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            OptionsCard(
              nextPage: AllPlayers(),
              icon: Icons.directions_run_rounded,
              title: 'Player Database',
              value: details.playersCount,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white10),
            const SizedBox(height: 16),
            SettingsCard(context: context),
          ],
        ),
      ),
    );
  }
}
