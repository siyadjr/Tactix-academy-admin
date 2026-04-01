import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/di/service_locator.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/bloc/all_teams_bloc.dart';
import 'package:tactix_academy_admin/Features/All%20teams/presentation/widgets/all_teams_view.dart';

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
