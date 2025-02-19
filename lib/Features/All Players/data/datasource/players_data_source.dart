import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_admin/Features/All%20Players/data/models/player_model.dart';

class PlayersDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch all players from Firestore
  Future<List<PlayerModel>> getAllPlayers() async {
    List<PlayerModel> players = [];

    // Fetch all players
    final snapShot = await _firestore.collection('Players').get();

    // Extract team IDs from player data
    Set<String> teamIds =
        snapShot.docs.map((doc) => doc['teamId'] as String? ?? '').toSet();

    // Fetch all team names in one query instead of multiple individual calls
    Map<String, String> teamNames = await getAllTeamNames(teamIds);

    for (var doc in snapShot.docs) {
      final teamId = doc['teamId'] ?? '';
      final teamName = teamNames[teamId] ?? 'No team Currently';

      final player = PlayerModel(
        id: doc.id,
        name: doc['name'],
        teamName: teamName,
        userProfile: doc['userProfile'],
        email: doc['email'],
      );
      players.add(player);
    }
    return players;
  }

  /// Fetch all team names at once to improve efficiency
  Future<Map<String, String>> getAllTeamNames(Set<String> teamIds) async {
    Map<String, String> teamNames = {};

    if (teamIds.isEmpty) return teamNames;

    final teamSnapshot = await _firestore
        .collection('Teams')
        .where(FieldPath.documentId, whereIn: teamIds.toList())
        .get();

    for (var doc in teamSnapshot.docs) {
      teamNames[doc.id] = doc['teamName'] ?? '';
    }

    return teamNames;
  }

Future<void> deletePlayer(String id) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Delete the player from the "Players" collection
  await firestore.collection('Players').doc(id).delete();

  // Find all teams that have this player in their "players" array
  QuerySnapshot teamsSnapshot = await firestore
      .collection('Teams')
      .where('players', arrayContains: id) // ✅ Find teams where "players" array contains the ID
      .get();

  // Remove the player ID from the "players" array in each matching team
  for (var doc in teamsSnapshot.docs) {
    await firestore.collection('Teams').doc(doc.id).update({
      'players': FieldValue.arrayRemove([id]) // ✅ Remove ID from array
    });
  }
}

}
