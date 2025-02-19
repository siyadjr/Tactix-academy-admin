import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_admin/Features/Home/data/models/home_details_model.dart';

class HomeScreenDataSource {
  Future<HomeDetailsModel> getHomeScreenDetails() async {
    final teamsSnapShot =
        await FirebaseFirestore.instance.collection('Teams').count().get();
    final playersSnapShot =
        await FirebaseFirestore.instance.collection('Players').count().get();
    final managersSnapShot =
        await FirebaseFirestore.instance.collection('Managers').count().get();

    return HomeDetailsModel(
      teamCount: teamsSnapShot.count.toString(), // ✅ Extract count
      playersCount: playersSnapShot.count.toString(),
      managersCount: managersSnapShot.count.toString(),
    );
  }
}
