import '../model/model.dart';

class IRouteProvider {
  Future<List<Route>>? fetchAll() {}
  Future<Route?>? getRoute(String id) {}
  void pushRoute(Route route) {}
  void deleteRoute(String id) {}
  void editRoute(Route route) {}
}