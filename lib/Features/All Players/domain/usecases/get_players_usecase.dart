import 'package:tactix_academy_admin/Features/All%20Players/data/models/player_model.dart';
import 'package:tactix_academy_admin/Features/All%20Players/domain/repositories/player_repository.dart';

class GetPlayersUsecase {
  final PlayerRepository playerRepository;
  GetPlayersUsecase(this.playerRepository);
  Future<List<PlayerModel>> getAllPlayers() async {
    return playerRepository.getAllPlayers();
  }
}
