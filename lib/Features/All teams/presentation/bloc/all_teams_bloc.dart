import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/domain/usecases/team_usecase.dart';

part 'all_teams_event.dart';
part 'all_teams_state.dart';

class AllTeamsBloc extends Bloc<AllTeamsEvent, AllTeamsState> {
  final TeamUsecase teamUsecase;
  AllTeamsBloc(this.teamUsecase) : super(AllTeamLoading()) {
    on<GetAllTeamsEvent>(_onGetAllTeam);
      on<DeleteTeamEvent>(_onDeleteTeam);
  }
  _onGetAllTeam(AllTeamsEvent event, Emitter<AllTeamsState> emit) async {
    emit(AllTeamLoading());
   try {
      final teams = await teamUsecase.getAllTeams();
      emit(AllTeamLoaded(teams));
    } catch (e) {
      emit(AllTeamBlocError("Failed to load players: ${e.toString()}"));
    }
  }


Future<void> _onDeleteTeam(DeleteTeamEvent event, Emitter<AllTeamsState> emit) async {
  emit(AllTeamLoading()); 
  try {
    await teamUsecase.deleteTeam(event.id);
    final teams = await teamUsecase.getAllTeams(); // Refresh teams after deletion
    emit(AllTeamLoaded(teams));
  } catch (e) {
    emit(AllTeamBlocError("Failed to delete team: ${e.toString()}"));
  }
}

}
