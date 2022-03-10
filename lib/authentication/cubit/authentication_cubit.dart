import 'package:bloc/bloc.dart';
import 'package:brummaps/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : super(
          const AuthenticationState.unauthenticated(),
        );

  void login({required String username, required String password}) {
    if (username == "salayna" && password == "password") {
      emit(const AuthenticationState.authenticated(
          User(username: 'salayna', mail: 'salayna@salayna.fr')));
    }
  }

  void logout() {
    emit(const AuthenticationState.unauthenticated());
  }
}
