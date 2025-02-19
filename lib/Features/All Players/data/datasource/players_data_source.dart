import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_admin/Features/All%20Players/data/models/player_model.dart';

class PlayersDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlayerModel>> getAllPlayers() async {
    final List<PlayerModel> players = [];
    final snapShot = await _firestore.collection('Players').get();

    // 1. Safely extract team IDs with existence check
    final Set<String> teamIds = snapShot.docs
        .where((doc) =>
            doc.data().containsKey('teamId')) // Filter docs with teamId field
        .map((doc) => doc['teamId'] as String?)
        .where(
            (teamId) => teamId != null && teamId.isNotEmpty) // Filter valid IDs
        .cast<String>()
        .toSet();

    // 2. Handle empty team IDs case
    final Map<String, String> teamNames =
        teamIds.isNotEmpty ? await getAllTeamNames(teamIds) : {};

    for (final doc in snapShot.docs) {
      // 3. Safe field access with fallbacks
      final data = doc.data();
      final teamId =
          data.containsKey('teamId') ? data['teamId'] as String? : null;

      players.add(PlayerModel(
        id: doc.id,
        name: data['name'] ?? 'Unknown Player',
        teamName: teamNames[teamId] ?? 'No Team',
        userProfile: data['userProfile'] ?? '',
        email: data['email'] ?? 'No Email',
      ));
    }

    return players;
  }

  Future<Map<String, String>> getAllTeamNames(Set<String> teamIds) async {
    final Map<String, String> teamNames = {};

    final teamSnapshot = await _firestore
        .collection('Teams')
        .where(FieldPath.documentId, whereIn: teamIds.toList())
        .get();

    for (final doc in teamSnapshot.docs) {
      teamNames[doc.id] = doc['teamName'] as String? ?? 'Unnamed Team';
    }

    return teamNames;
  }

  Future<void> deletePlayer(String id) async {
    // 4. Batch write for atomic operations
    final batch = _firestore.batch();

    // Delete player document
    final playerRef = _firestore.collection('Players').doc(id);
    batch.delete(playerRef);

    // Find teams containing this player
    final teamsQuery = await _firestore
        .collection('Teams')
        .where('players', arrayContains: id)
        .get();

    // Update all matching teams
    for (final teamDoc in teamsQuery.docs) {
      batch.update(teamDoc.reference, {
        'players': FieldValue.arrayRemove([id])
      });
    }

    await batch.commit();
  }
}
