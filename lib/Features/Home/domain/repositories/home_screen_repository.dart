import 'package:tactix_academy_admin/Features/Home/domain/entities/home_details.dart';

abstract class HomeScreenRepository{
  Future<HomeDetails>getHomeDetails();
}