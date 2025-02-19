  import 'package:tactix_academy_admin/Features/Authentication/domain/repositories/auth_repository.dart';

  class LoginUseCase {
    final AuthRepository repository;
    LoginUseCase(this.repository);
    Future<bool> callLogin(String name, String password) async {
      return repository.login(name, password);
    }
  }
