import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_admin/Features/All%20teams/data/models/team_model.dart';

class TeamDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TeamModel>> getAllTeam() async {
    final List<TeamModel> teams = [];
    final snapshot = await _firestore.collection('Teams').get();

    for (var doc in snapshot.docs) {
      final data = doc.data(); // Get the document data

      if (data != null) {
        final playersList = data['players'] ?? []; // Ensure list is not null
        final playersCount =
            (playersList is List) ? playersList.length.toString() : '0';

        // Fetch manager details in one query instead of two separate ones
        final managerData = await getManagerDetails(doc['managerId']);
        

        final team = TeamModel.fromJson({
          'id': doc.id, // Assign document ID separately
          'playersCount': playersCount,
          'name': managerData['name'] ?? 'Unknown', // Assign safely
          'managerPhoto': managerData['userProfile'] ?? '',

          ...data, // Spread the document data
        });

        teams.add(team);
      }
    }
    return teams;
  }

  Future<void> deleteTeam(String id) async {
    final firestore = FirebaseFirestore.instance;
    log('called delete function!'); // Delete the team document
    await firestore.collection('Teams').doc(id).delete();

    // Find all players with this teamId
    final playersSnapshot = await firestore
        .collection('Players')
        .where('teamId', isEqualTo: id)
        .get();

    // Batch update to remove teamId field
    WriteBatch batch = firestore.batch();
    for (var doc in playersSnapshot.docs) {
      batch.update(doc.reference, {'teamId': FieldValue.delete()});
    }
    await batch.commit(); // Commit all updates in one request
  }

  Future<Map<String, dynamic>> getManagerDetails(String id) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('Managers').doc(id).get();
    final data = snapshot.data();
    log(data?['name']);
    return {
      'name': data?['name'] ?? 'Unknown',
      'userProfile': data?['userProfile'] ?? '',
    };
  }
}
