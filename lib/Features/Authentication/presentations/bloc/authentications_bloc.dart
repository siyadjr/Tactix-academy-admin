import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix_academy_admin/Features/Authentication/domain/repositories/auth_repository.dart';
import 'package:tactix_academy_admin/Features/Authentication/domain/usecases/login_use_case.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/bloc/authentications_event.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/bloc/authentications_state.dart';

// class AuthEvent {} // Base class for events

// class LoginEvent extends AuthEvent {
//   final String email;
//   final String password;

//   LoginEvent(this.email, this.password);
// }

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final success = await loginUseCase.callLogin(event.name, event.password);
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure());
      }
    });
  }
}
