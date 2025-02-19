import 'package:tactix_academy_admin/Features/All%20Players/data/models/player_model.dart';

abstract class PlayerRepository {
  Future<List<PlayerModel>> getAllPlayers();
}
