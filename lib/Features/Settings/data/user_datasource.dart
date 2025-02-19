import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserName(String newValue) async {
    final querySnapshot = await _firestore.collection('Admin').limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({'userName': newValue});
    } else {
      throw Exception("No admin document found");
    }
  }

  Future<void> updatePassword(String newValue) async {
    final querySnapshot = await _firestore.collection('Admin').limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({'password': newValue});
    } else {
      throw Exception("No admin document found");
    }
  }
}
