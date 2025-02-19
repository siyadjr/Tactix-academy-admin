import 'package:tactix_academy_admin/Features/All%20teams/domain/entities/team.dart';

class TeamModel extends Team {
  TeamModel({
    required String id,
    required String name,
    required String managerId,
    required String managerPhoto,
    required String teamPhoto,
    required String playersCount,
    required String teamName,
  }) : super(
          id: id,
          name: name,
          managerId: managerId,
          managerPhoto: managerPhoto,
          teamPhoto: teamPhoto,
          playersCount: playersCount,
          teamName: teamName,
        );

  // Factory method to create TeamModel from Firestore document
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? '',
      name: json['name'] ,
      managerId: json['managerId'] ?? '',
      managerPhoto: json['managerPhoto'] ?? '',
      teamPhoto: json['teamPhoto'] ?? '',
      playersCount: json['playersCount'].toString(), // Ensure it's a String
      teamName: json['teamName'] ?? '',
    );
  }

  // Method to convert TeamModel to a JSON format (useful for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'managerId': managerId,
      'managerPhoto': managerPhoto,
      'teamPhoto': teamPhoto,
      'playersCount': playersCount,
      'teamName': teamName,
    };
  }
}
