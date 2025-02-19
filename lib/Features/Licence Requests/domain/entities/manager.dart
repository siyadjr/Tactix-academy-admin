import 'package:cloud_firestore/cloud_firestore.dart';

class Manager {
  final String name;
  final String email;
  final String id;
  final String licenseUrl;
  final String licenseStatus;

  Manager({
    required this.name,
    required this.email,
    required this.id,
    required this.licenseUrl,
    required this.licenseStatus,
  });

  // Method to convert Firestore data into Manager instance
  factory Manager.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Manager(
      name: data['name'] ?? 'No Name',
      email: data['email'] ?? 'No Email',
      id: doc.id,
      licenseUrl: data['licenseUrl'] ?? '',
      licenseStatus: data['licenseStatus'] ?? 'pending',
    );
  }

  // Optionally, you can add methods to serialize the data back to Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'licenseUrl': licenseUrl,
      'licenseStatus': licenseStatus,
    };
  }
}
