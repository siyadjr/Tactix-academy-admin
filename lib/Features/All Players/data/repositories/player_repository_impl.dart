import 'package:tactix_academy_admin/Features/All%20Players/data/datasource/players_data_source.dart';
import 'package:tactix_academy_admin/Features/All%20Players/data/models/player_model.dart';
import 'package:tactix_academy_admin/Features/All%20Players/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayersDataSource dataSource;
  PlayerRepositoryImpl(this.dataSource);
  @override
  Future<List<PlayerModel>> getAllPlayers() async {
    return dataSource.getAllPlayers();
  }
}
