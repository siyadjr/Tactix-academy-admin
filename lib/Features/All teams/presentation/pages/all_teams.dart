import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/di/service_locator.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/bloc/all_teams_bloc.dart';

class AllTeams extends StatelessWidget {
  const AllTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllTeamsBloc>()..add(GetAllTeamsEvent()),
      child: const AllTeamsView(),
    );
  }
}

class AllTeamsView extends StatelessWidget {
  const AllTeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Management'),
        backgroundColor: Colors.blue[800],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Teams',
            onPressed: () =>
                context.read<AllTeamsBloc>().add(GetAllTeamsEvent()),
          ),
        ],
      ),
      body: BlocConsumer<AllTeamsBloc, AllTeamsState>(
        listener: (context, state) {
          if (state is AllTeamBlocError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red[700],
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AllTeamLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllTeamLoaded) {
            return TeamGridView(teams: state.teams);
          } else if (state is AllTeamBlocError) {
            return ErrorView(
              message: state.message,
              onRetry: () =>
                  context.read<AllTeamsBloc>().add(GetAllTeamsEvent()),
            );
          }
          return const EmptyTeamsView();
        },
      ),
    );
  }
}

class TeamGridView extends StatelessWidget {
  final List<TeamModel> teams;

  const TeamGridView({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    if (teams.isEmpty) {
      return const EmptyTeamsView();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive grid calculation
        double cardWidth = 320;
        int crossAxisCount;

        if (constraints.maxWidth > 1400) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 1000) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 700) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        double aspectRatio = (cardWidth / 420); // Width to height ratio

        return Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return TeamCard(team: teams[index]);
              },
            ),
          ),
        );
      },
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamModel team;

  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Header with Photo
          _buildTeamHeader(),

          // Team Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTeamInfo(),
                  const Divider(height: 24),
                  _buildManagerInfo(),
                  const Spacer(),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamHeader() {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          color: Colors.blue[50],
          child: team.teamPhoto.isNotEmpty
              ? Image.network(
                  team.teamPhoto,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.sports_soccer,
                        size: 64,
                        color: Colors.blue[200],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                )
              : Center(
                  child: Icon(
                    Icons.sports_soccer,
                    size: 64,
                    color: Colors.blue[200],
                  ),
                ),
        ),
        // Gradient overlay for better text visibility
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),
        // Team name on the gradient
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Text(
            team.teamName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.black45,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.people, size: 18, color: Colors.blue[700]),
              const SizedBox(width: 6),
              Text(
                '${team.playersCount} Players',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.sports, size: 18, color: Colors.orange[700]),
              const SizedBox(width: 6),
              Text(
                'Active',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.orange[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildManagerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Team Manager',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: team.managerPhoto.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        team.managerPhoto,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.grey,
                          );
                        },
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 24,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    team.managerId != '' ? team.name : 'Manager Name',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ID: ${team.managerId}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
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

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            // View team details navigation would go here
          },
          icon: const Icon(Icons.visibility),
          label: const Text('VIEW DETAILS'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue[700],
            side: BorderSide(color: Colors.blue[700]!),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () => _showDeleteConfirmation(context),
          icon: const Icon(Icons.delete),
          label: const Text('DELETE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[600],
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.all(16),
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(Icons.warning_amber_rounded, color: Colors.red[700]),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Delete Team Confirmation',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(text: 'Are you sure you want to delete '),
                  TextSpan(
                    text: team.teamName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: '?'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Colors.blue[700], size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Important Information',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This action will:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildInfoItem('• Delete the team permanently'),
                  _buildInfoItem('• Remove team assignments from all players'),
                  _buildInfoItem('• Retain individual player records'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[800],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<AllTeamsBloc>().add(DeleteTeam(team.id));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${team.teamName} has been deleted'),
                  backgroundColor: Colors.green[700],
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.delete, size: 18),
            label: const Text('DELETE TEAM'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}

class EmptyTeamsView extends StatelessWidget {
  const EmptyTeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.groups_outlined,
              size: 80,
              color: Colors.blue[200],
            ),
            const SizedBox(height: 24),
            Text(
              'No Teams Found',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Start creating teams to manage your players effectively. Teams help organize players for matches, training sessions, and more.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('CREATE NEW TEAM'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                // Navigation to team creation page would go here
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Unable to Load Teams',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, size: 16, color: Colors.orange[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Error Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('TRY AGAIN'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
