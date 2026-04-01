import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Core/Widgets/custom_widgets.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/bloc/all_teams_bloc.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;
  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Team Header (Gradient + Image)
          _buildHeader(team),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStats(team),
                const SizedBox(height: 20),
                const Divider(color: Colors.white10),
                const SizedBox(height: 20),
                _buildManagerSection(team),
                const SizedBox(height: 24),
                _buildActions(context, team),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(TeamModel team) {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              team.teamPhoto,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: kPrimaryColor.withOpacity(0.1),
                child: const Icon(Icons.groups_rounded,
                    size: 48, color: kPrimaryColor),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 16,
            right: 16,
            child: Text(
              team.teamName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(TeamModel team) {
    return Row(
      children: [
        _buildStatChip(Icons.people_rounded, '${team.playersCount} Players',
            kPrimaryColor),
        const SizedBox(width: 12),
        _buildStatChip(Icons.check_circle_rounded, 'Active', kSuccessColor),
      ],
    );
  }

  Widget _buildStatChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildManagerSection(TeamModel team) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MANAGER',
          style: TextStyle(
            color: kTextColorSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: kPrimaryColor.withOpacity(0.1),
              backgroundImage: NetworkImage(team.managerPhoto),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    team.name.isNotEmpty ? team.name : 'Unknown Manager',
                    style: const TextStyle(
                      color: kTextColorPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'ID: ${team.managerId}',
                    style: const TextStyle(
                        color: kTextColorSecondary, fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, TeamModel team) {
    return AppButton(
      text: 'Remove Team',
      onPressed: () => _showDeleteConfirmation(context, team),
    );
  }

  void _showDeleteConfirmation(BuildContext context, TeamModel team) {
    final bloc = context.read<AllTeamsBloc>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kSurfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Team',
            style: TextStyle(color: kTextColorPrimary)),
        content: Text(
          'Are you sure you want to delete ${team.teamName}? Status, players, and manager links for this team will be lost.',
          style: const TextStyle(color: kTextColorSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL',
                style: TextStyle(color: kTextColorSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kErrorColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              bloc.add(DeleteTeamEvent(team.id));
              Navigator.pop(context);
              AppSnackBar.showError(
                  context, '${team.teamName} has been removed.');
            },
            child: const Text('DELETE TEAM',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
