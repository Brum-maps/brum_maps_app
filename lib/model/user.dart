import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String mail;
  final String? password;
  final String? profileImageLink;

  const User(
      {required this.username,
      required this.mail,
      this.password,
      this.profileImageLink});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      mail: json['mail'],
      profileImageLink: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'mail': mail,
      'profile_image': profileImageLink
    };
  }

  static const empty = User(username: '', mail: '');

  @override
  // TODO: implement props
  List<Object?> get props => [username, mail, password, profileImageLink];
}
