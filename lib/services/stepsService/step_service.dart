import 'dart:convert';

import 'package:brummaps/model/model.dart';
import 'package:http/http.dart' as http;

class StepsService {
  static StepsService? _instance;

  static StepsService get instance {
    _instance ??= StepsService();
    return _instance!;
  }

  Future<List<Step>> getSteps(int limit) async {
    String url = "http://10.33.3.195:3000/bru-maps/step/randomSteps/$limit";
    http.Response response = await http.get(Uri.parse(url));

    var json = jsonDecode(response.body);

    List<Step> steps = (json as List).map((e) => Step.fromJson(e)).toList();

    return steps;
  }

  Future<void> sendSteps(Map<String, dynamic> json) async {
    var body = jsonEncode(json);
    String url = "http://10.33.3.195:3000/bru-maps/itinerary/custom";

    http.Response response = await http.post(Uri.parse(url), body: body);

    // print(response);
  }
}
