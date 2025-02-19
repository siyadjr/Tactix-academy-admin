

import 'package:tactix_academy_admin/Features/Authentication/domain/enitities/user.dart';

class UserModel extends User {
  UserModel({required String name, required String password})
      : super(name: name, password: password);

  // Convert Firebase JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['userName'],
      password: json['password'],
    );
  }

  // Convert UserModel to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'userName': name,
      'password': password,
    };
  }
}
