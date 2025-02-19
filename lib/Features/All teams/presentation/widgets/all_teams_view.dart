import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/bloc/all_teams_bloc.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/pages/all_teams.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/all_team_empty_state.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/all_team_error_view.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/team_grid_view.dart';

class AllTeamsView extends StatelessWidget {
  const AllTeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Team Management',
            style: TextStyle(color: splashColor, fontWeight: FontWeight.bold)),
        backgroundColor: secondarySplash,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: splashColor),
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
                content: Text(state.message,
                    style: const TextStyle(color: Colors.white)),
                backgroundColor: Colors.red[700],
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AllTeamLoading) {
            return const Center(
              child: CircularProgressIndicator(color: secondarySplash),
            );
          }
          if (state is AllTeamLoaded) {
            return TeamGridView(teams: state.teams);
          }
          if (state is AllTeamBlocError) {
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