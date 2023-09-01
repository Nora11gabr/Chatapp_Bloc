import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          Future<void> loginUser() async {
            UserCredential user = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: event.Email, password: event.Password);
          }

          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            emit(LoginFailure(ErrorMessage: "Wrong password"));
          } else if (e.code == 'user-not-found') {
            emit(LoginFailure(ErrorMessage: "User not found"));
          }
        } on Exception catch (e) {
          emit(LoginFailure(ErrorMessage: "something went wrong"));
        }
      }
    });
  }
}
