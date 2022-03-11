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
    String url = "http://localhost:3000/bru-maps/step/randomSteps/$limit";
    http.Response response = await http.get(Uri.parse(url));

    var json = jsonDecode(response.body);

    List<Step> steps = json.map((e) => Step.fromJson(e));

    return steps;
  }
}
