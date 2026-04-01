import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Core/Widgets/custom_widgets.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/bloc/all_teams_bloc.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/all_team_empty_state.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/all_team_error_view.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/team_grid_view.dart';

class AllTeamsView extends StatelessWidget {
  const AllTeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Text(
          'Team Management',
          style: TextStyle(
            color: kTextColorPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTextColorPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: kPrimaryColor),
            onPressed: () => context.read<AllTeamsBloc>().add(GetAllTeamsEvent()),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: BlocConsumer<AllTeamsBloc, AllTeamsState>(
        listener: (context, state) {
          if (state is AllTeamBlocError) {
            AppSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AllTeamLoading) {
            return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
          }
          if (state is AllTeamLoaded) {
            return TeamGridView(teams: state.teams);
          }
          if (state is AllTeamBlocError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<AllTeamsBloc>().add(GetAllTeamsEvent()),
            );
          }
          return const EmptyTeamsView();
        },
      ),
    );
  }
}