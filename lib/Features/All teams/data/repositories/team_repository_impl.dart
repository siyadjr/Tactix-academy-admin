
import 'package:tactix_academy_admin/Features/All%20teams/data/datasource/team_datasource.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';
import 'package:tactix_academy_admin/Features/All%20teams/domain/repositories/team_repository.dart';

class TeamRepositoryImpl implements TeamRepository {
  final TeamDatasource dataSource;
  TeamRepositoryImpl(this.dataSource);
  @override
  Future<List<TeamModel>> getAllTeams() async {
    return dataSource.getAllTeam();
  }
@override
  Future<void> deleteTeam(String id) async {
    return dataSource.deleteTeam(id);
  }
}
