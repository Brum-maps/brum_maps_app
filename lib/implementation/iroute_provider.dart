import '../model/model.dart';

class IRouteProvider {
  List<Route>? fetchAll() {}
  Route? getRoute(String id) {}
  void pushRoute(Route route) {}
  void deleteRoute(String id) {}
  void editRoute(Route route) {}
}