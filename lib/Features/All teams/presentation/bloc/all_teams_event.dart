part of 'all_teams_bloc.dart';

sealed class AllTeamsEvent extends Equatable {
  const AllTeamsEvent();

  @override
  List<Object> get props => [];
}

class GetAllTeamsEvent extends AllTeamsEvent {}

class DeleteTeam extends AllTeamsEvent {
  final String id;
  const DeleteTeam(this.id);
}
