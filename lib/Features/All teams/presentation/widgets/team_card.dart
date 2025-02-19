import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/pages/all_teams.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;
  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Card(
          elevation: 8,
          shadowColor: secondarySplash.withOpacity(0.4),
          color: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: secondarySplash.withOpacity(0.7),
              width: 1.5,
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildTeamHeader(team),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTeamInfo(team),
                    const Divider(
                      height: 24,
                      color: secondarySplash,
                      thickness: 0.5,
                    ),
                    buildManagerInfo(team),
                    const Spacer(),
                    buildActionButtons(context,team),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
