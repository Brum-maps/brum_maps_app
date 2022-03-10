import 'package:brummaps/implementation/iauth_provider.dart';
import 'package:brummaps/model/user.dart';

class MockAuthenthicationController implements IAuthController {
  @override
  User? login({required String username, required String password}) {
    User user;
    if (username == "salayna" && password == "password") {
      user = const User(username: 'salayna', mail: 'salayna@salayna.fr');
      return user;
    } else {
      return null;
    }
  }
}
