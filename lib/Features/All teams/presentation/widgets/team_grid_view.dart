import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/pages/all_teams.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/all_team_empty_state.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/team_card.dart';

class TeamGridView extends StatelessWidget {
  final List<TeamModel> teams;
  const TeamGridView({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    if (teams.isEmpty) return const EmptyTeamsView();

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1400
            ? 4
            : constraints.maxWidth > 1000
                ? 3
                : constraints.maxWidth > 700
                    ? 2
                    : 1;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.85,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: teams.length,
            itemBuilder: (context, index) => TeamCard(team: teams[index]),
          ),
        );
      },
    );
  }
}
