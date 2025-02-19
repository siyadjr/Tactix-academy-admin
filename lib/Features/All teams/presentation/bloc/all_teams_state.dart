part of 'all_teams_bloc.dart';

sealed class AllTeamsState extends Equatable {
  const AllTeamsState();

  @override
  List<Object> get props => [];
}

final class AllTeamsInitial extends AllTeamsState {}

final class AllTeamLoading extends AllTeamsState {}

final class AllTeamLoaded extends AllTeamsState {
  final List<TeamModel> teams;

  const AllTeamLoaded(this.teams);

  @override
  List<Object> get props => [];
}

final class AllTeamBlocError extends AllTeamsState {
  final String message;

  const AllTeamBlocError(this.message);
}
