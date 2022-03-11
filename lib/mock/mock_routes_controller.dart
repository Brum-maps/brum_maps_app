import 'package:brummaps/implementation/iroute_provider.dart';
import 'package:brummaps/model/route.dart';

class MockRouteController implements IRouteProvider {
  @override
  void deleteRoute(String id) {
    // TODO: implement deleteRoute
  }

  @override
  void editRoute(Route route) {
    // TODO: implement editRoute
  }

  @override
  Future<List<Route>>? fetchAll() async {
    print("I'm here in MockRouteController");
    return [
      Route(title: "This is a Route", description: "Hmmmm this is a description I don't really know what else to tell you", steps: [], distance: 56, duration: '120'),
      Route(title: "This is a Route 2", description: "Hmmmm this is a description I don't really know what else to tell you", steps: [], distance: 32, duration: '120'),
      Route(title: "This is a Route", description: "Hmmmm this is a description I don't really know what else to tell you", steps: [], distance: 90, duration: '120'),
      Route(title: "This is a Route", description: "Hmmmm this is a description I don't really know what else to tell you", steps: [], distance: 45, duration: '120'),
      Route(title: "This is a Route", description: "Hmmmm this is a description I don't really know what else to tell you", steps: [], distance: 67, duration: '120'),
    ];
  }

  @override
  Route? getRoute(String id) {
    // TODO: implement getRoute
    throw UnimplementedError();
  }

  @override
  void pushRoute(Route route) {
    // TODO: implement pushRoute
  }
  
}