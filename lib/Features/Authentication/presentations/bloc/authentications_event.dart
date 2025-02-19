


class AuthEvent {} // Base class for events

class LoginEvent extends AuthEvent {
  final String name;
  final String password;

  LoginEvent(this.name, this.password);
}
