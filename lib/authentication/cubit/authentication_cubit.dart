import 'package:bloc/bloc.dart';
import 'package:brummaps/implementation/iauth_provider.dart';
import 'package:brummaps/mock/mock_authentication_controller.dart';
import 'package:brummaps/model/user.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final IAuthController _authController;
  AuthenticationCubit({IAuthController? authController})
      : _authController = authController ?? MockAuthenthicationController(),
        super(
          const AuthenticationState.unauthenticated(),
        );

  void login({required String username, required String password}) {
    var user = _authController.login(username: username, password: password);
    if (user != null) {
      emit(AuthenticationState.authenticated(user));
    }
  }

  void logout() {
    emit(const AuthenticationState.unauthenticated());
  }
}
