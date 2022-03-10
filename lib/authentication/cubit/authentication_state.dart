part of 'authentication_cubit.dart';

enum AuthenticationStatus { unauthenticated, authenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState._({
    required this.status,
    this.user = User.empty,
  });
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  @override
  List<Object?> get props => [status, user];
}
