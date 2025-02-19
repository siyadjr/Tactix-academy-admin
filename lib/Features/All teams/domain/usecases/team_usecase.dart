import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/domain/repositories/team_repository.dart';

class TeamUsecase{
   final TeamRepository teamRepository;
  TeamUsecase(this.teamRepository);
  Future<List<TeamModel>> getAllTeams() async {
    return teamRepository.getAllTeams();
  }

  Future<void> deleteTeam(String id) async {
    teamRepository.deleteTeam(id);
  }
}