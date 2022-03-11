import 'dart:convert';

import 'package:brummaps/implementation/iroute_provider.dart';
import 'package:brummaps/model/route.dart';
import 'package:http/http.dart' as http;

class LocalRouteController implements IRouteProvider {

  final uri =  "http://10.33.3.195:3000/bru-maps";
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
    List<Route> routes = [];
    final response = await http.get(Uri.parse(uri+'/itinerary/getAll'));
    var json = jsonDecode(response.body);
    routes = (json as List).map((e) => Route.fromJson(e)).toList();
    print(routes);
    return routes;
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
