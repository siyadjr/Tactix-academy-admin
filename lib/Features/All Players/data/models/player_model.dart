import 'package:tactix_academy_admin/Features/All%20Players/domain/entities/player.dart';

class PlayerModel extends Player {
  PlayerModel({
    required String id,
    required String name,
    required String teamName,
    required String userProfile,
    required String email,
  }) : super(
          id: id,
          email: email,
          name: name,
          teamName: teamName,
          userProfile: userProfile,
        );

  /// Factory constructor to create a `PlayerModel` from JSON
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      teamName: json['teamName'] ?? '',
      userProfile: json['userProfile'] ?? '',
      email: json['email'] ?? '',
    );
  }

  /// Converts `PlayerModel` to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teamName': teamName,
      'userProfile': userProfile,
      'email': email,
    };
  }
}
