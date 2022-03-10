import 'package:brummaps/model/user.dart';

class IAuthController {
  User? login({required String username, required String password}) {}
  void logout() {}
}
