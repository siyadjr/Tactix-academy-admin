import 'package:tactix_academy_admin/Features/Home/data/models/home_details_model.dart';
import 'package:tactix_academy_admin/Features/Home/domain/entities/home_details.dart';
import 'package:tactix_academy_admin/Features/Home/domain/repositories/home_screen_repository.dart';

class HomeUseCase {
  final HomeScreenRepository repository;
  HomeUseCase(this.repository);
  Future<HomeDetails> callGetHomeDetails() async {
    return repository.getHomeDetails();
  }
}
