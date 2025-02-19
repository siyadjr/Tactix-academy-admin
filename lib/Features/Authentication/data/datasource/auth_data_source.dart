import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_admin/Features/Authentication/Data/Models/user_model.dart';

class AuthDataSource {
  Future<bool> getuserNameAndPassword(String name, String pass) async {
    final snapShot = await FirebaseFirestore.instance.collection('Admin').get();

    if (snapShot.docs.isNotEmpty) {
      final data =
          snapShot.docs.first.data(); 
      final user = UserModel.fromJson(data);
      return user.name == name && user.password == pass;
    }
    return false;
  }
}
