part of 'players_bloc_bloc.dart';

sealed class PlayersBlocState extends Equatable {
  const PlayersBlocState();
  
  @override
  List<Object> get props => [];
}

final class PlayersBlocLoading extends PlayersBlocState {}

final class PlayersBlocLoaded extends PlayersBlocState {
  final List<PlayerModel> players;

  const PlayersBlocLoaded(this.players);

  @override
  List<Object> get props => [players];
}

final class PlayersBlocError extends PlayersBlocState {
  final String message;

  const PlayersBlocError(this.message);

  @override
  List<Object> get props => [message];
}
