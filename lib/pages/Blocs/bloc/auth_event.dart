part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String Email;
  final String Password;
  LoginEvent({required this.Email, required this.Password});
}

class RegisterEvent extends AuthEvent {
  final String Email;
  final String Password;
  RegisterEvent({required this.Email, required this.Password});
}
