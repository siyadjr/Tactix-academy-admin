import 'package:tactix_academy_admin/Features/Home/data/datasource/home_screen_data_source.dart';
import 'package:tactix_academy_admin/Features/Home/data/models/home_details_model.dart';
import 'package:tactix_academy_admin/Features/Home/domain/repositories/home_screen_repository.dart';

class HomeScreenRepositoryImpl implements HomeScreenRepository {
  final HomeScreenDataSource homeScreenDataSource;
  HomeScreenRepositoryImpl(this.homeScreenDataSource);
  
  @override
  Future<HomeDetailsModel> getHomeDetails() async {
    return homeScreenDataSource.getHomeScreenDetails();
  }
}
