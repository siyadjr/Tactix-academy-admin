import 'package:tactix_academy_admin/Features/Authentication/data/datasource/auth_data_source.dart';
import 'package:tactix_academy_admin/Features/Authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource); // ✅ Inject via constructor

  @override
  Future<bool> login(String name, String pass) async {
    return authDataSource.getuserNameAndPassword(name, pass);
  }
}
