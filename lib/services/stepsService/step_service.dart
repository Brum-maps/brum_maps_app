import 'dart:convert';

import 'package:http/http.dart' as http;

class StepsService {
  static StepsService? _instance;

  static StepsService get instance {
    _instance ??= StepsService();
    return _instance!;
  }

  Future<Map<String, dynamic>> getSteps(int limit) async {
    String url = "http://localhost:3000/bru-maps/step/randomSteps/$limit";
    http.Response response = await http.get(Uri.parse(url));

    print(response.body);

    Map<String, dynamic> json = jsonDecode(response.body);

    print(json);

    return json;
  }
}
