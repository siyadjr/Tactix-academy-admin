import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Core/Constants/di/service_locator.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/bloc/all_teams_bloc.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/all_teams_view.dart';

class AllTeams extends StatelessWidget {
  const AllTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllTeamsBloc>()..add(GetAllTeamsEvent()),
      child: Builder(builder: (context) => const AllTeamsView()),
    );
  }
}





  Widget buildTeamHeader(TeamModel team) => Container(
        height: 130,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              secondarySplash,
              secondarySplash.withOpacity(0.6),
              Colors.black.withOpacity(0.8),
            ],
            stops: const [0.0, 0.65, 1.0],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  stops: const [0.7, 1.0],
                ).createShader(bounds),
                blendMode: BlendMode.darken,
                child: Center(
                  child: Image.network(
                    team.teamPhoto,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 130,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: secondarySplash.withOpacity(0.2),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white54,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  team.teamName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildTeamInfo(TeamModel team) => Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          Chip(
            label: Text('${team.playersCount} Players',
                style: const TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            backgroundColor: splashColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            avatar: const Icon(Icons.people, color: textColor, size: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Chip(
            label: const Text('Active',
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            backgroundColor: Colors.green[700],
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            avatar:
                const Icon(Icons.check_circle, color: Colors.white, size: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      );

  Widget buildManagerInfo(TeamModel team) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.manage_accounts, color: splashColor, size: 16),
              SizedBox(width: 6),
              Text('Team Manager',
                  style: TextStyle(
                    color: splashColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: secondarySplash.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: secondarySplash.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: secondarySplash,
                    backgroundImage: NetworkImage(team.managerPhoto),
                    onBackgroundImageError: (_, __) {},
                    child: team.managerPhoto.isEmpty
                        ? const Icon(Icons.person, color: Colors.white70)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        team.managerId.isNotEmpty ? team.name : 'No Manager',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${team.managerId}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildActionButtons(BuildContext context,TeamModel team) => Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => showDeleteConfirmation(context, team),
              icon: const Icon(Icons.delete_forever, size: 18),
              label: const Text('DELETE TEAM'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                shadowColor: Colors.red.withOpacity(0.4),
              ),
            ),
          ),
        ],
      );

  void showDeleteConfirmation(BuildContext context,TeamModel team) {
    final bloc = BlocProvider.of<AllTeamsBloc>(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red[400], size: 28),
            const SizedBox(width: 10),
            const Text('Delete Team?',
                style:
                    TextStyle(color: splashColor, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete ${team.teamName}?',
              style: const TextStyle(color: Colors.white70, height: 1.5),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[900]?.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[800]!.withOpacity(0.5)),
              ),
              child: const Text(
                'This action cannot be undone. All team data will be permanently removed.',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: secondarySplash.withOpacity(0.7), width: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text('CANCEL'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteTeamEvent(team.id));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text('Deleted ${team.teamName}'),
                    ],
                  ),
                  backgroundColor: secondarySplash,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 3),
                  width: 300,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              );
            },
            icon: const Icon(Icons.delete_forever, size: 18),
            label: const Text('DELETE'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              elevation: 4,
              shadowColor: Colors.red.withOpacity(0.4),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }


