import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tactix_academy_admin/Features/All%20Players/domain/usecases/get_players_usecase.dart';
import 'package:tactix_academy_admin/Features/All%20Players/data/models/player_model.dart';

part 'players_bloc_event.dart';
part 'players_bloc_state.dart';

class PlayersBloc extends Bloc<PlayersBlocEvent, PlayersBlocState> {
  final GetPlayersUsecase getPlayersUsecase;

  PlayersBloc(this.getPlayersUsecase) : super(PlayersBlocLoading()) {
    // Register the event handler using on<EventType>
    on<GetAllPlayersEvent>(_onGetAllPlayers);
    on<DeletePlayerEvent>(_onDeletePlayer);
  }

  // Separate method for handling the event
  Future<void> _onGetAllPlayers(
    GetAllPlayersEvent event,
    Emitter<PlayersBlocState> emit,
  ) async {
    emit(PlayersBlocLoading());
    try {
      final players = await getPlayersUsecase.getAllPlayers();
      emit(PlayersBlocLoaded(players));
    } catch (e) {
      emit(PlayersBlocError("Failed to load players: ${e.toString()}"));
    }
  }

  _onDeletePlayer(
      DeletePlayerEvent event, Emitter<PlayersBlocState> emit) async {
    emit(PlayersBlocLoading());
   try {
        await getPlayersUsecase.deletePlayer(event.id);
        // Refresh player list after deletion
        final players = await getPlayersUsecase.getAllPlayers();
        emit(PlayersBlocLoaded(players));
      } catch (e) {
        emit(PlayersBlocError(e.toString()));
      }
    
  }
}
