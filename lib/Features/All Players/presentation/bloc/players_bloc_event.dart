part of 'players_bloc_bloc.dart';

sealed class PlayersBlocEvent extends Equatable {
  const PlayersBlocEvent();

  @override
  List<Object> get props => [];
}

class GetAllPlayersEvent extends PlayersBlocEvent {}

class DeletePlayerEvent extends PlayersBlocEvent {
  final String id;
  const DeletePlayerEvent(this.id);
}
