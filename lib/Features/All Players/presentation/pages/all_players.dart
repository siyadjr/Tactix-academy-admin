import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Core/Constants/di/service_locator.dart';
import 'package:tactix_academy_admin/Features/All%20Players/domain/usecases/get_players_usecase.dart';
import 'package:tactix_academy_admin/Features/All%20Players/presentation/bloc/players_bloc_bloc.dart';
import 'package:tactix_academy_admin/Features/All%20Players/presentation/widgets/player_cards.dart';

class AllPlayers extends StatelessWidget {
  const AllPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PlayersBloc>()..add(GetAllPlayersEvent()),
      child: const AllPlayersView(),
    );
  }
}

class AllPlayersView extends StatelessWidget {
  const AllPlayersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('All Players', style: TextStyle(color: Colors.white)),
        elevation: 2,
      ),
      body: BlocBuilder<PlayersBloc, PlayersBlocState>(
        builder: (context, state) {
          if (state is PlayersBlocLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlayersBlocLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Responsive grid calculation
                  final crossAxisCount = constraints.maxWidth > 1200
                      ? 4
                      : constraints.maxWidth > 800
                          ? 3
                          : constraints.maxWidth > 600
                              ? 2
                              : 1;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: state.players.length,
                    itemBuilder: (context, index) {
                      final player = state.players[index];
                      return PlayerCard(
                        player: player,
                        onDelete: (player) {
                          BlocProvider.of<PlayersBloc>(context)
                              .add(DeletePlayerEvent(player.id));
                        },
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is PlayersBlocError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    "Error: ${state.message}",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_off, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  "No players found",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
