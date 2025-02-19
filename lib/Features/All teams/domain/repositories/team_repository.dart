
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';

abstract class TeamRepository {
  Future<List<TeamModel>> getAllTeams();
  Future<void> deleteTeam(String id);
}
