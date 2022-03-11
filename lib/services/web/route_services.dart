import 'dart:convert';
import 'dart:developer';

import 'package:brummaps/implementation/iroute_provider.dart';
import 'package:brummaps/model/route.dart';
import 'package:http/http.dart' as http;

class LocalRouteController implements IRouteProvider {
  final uri = "http://10.33.3.195:3000/bru-maps";
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
    final response = await http.get(Uri.parse(uri + '/itinerary/getAll'));
    var json = jsonDecode(response.body);
    print(routes);
    routes = (json as List).map((e) => Route.fromJson(e)).toList();

    return routes;
  }

  @override
  Future<Route?> getRoute(String id) async {
    String url = uri + '/itinerary/$id';
    http.Response response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    Route route = Route.fromJson(json[0], fetchAll: false);

    return route;
  }

  @override
  void pushRoute(Route route) {
    // TODO: implement pushRoute
  }
}
