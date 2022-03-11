import 'dart:convert';

import 'package:http/http.dart' as http;

class GoogleMapsService {
  Future getImageUrlFromReference(String? ref) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$ref&key=AIzaSyB-JOAag0t_pzNaZusRiOcG6-Xx8To60N8";
    Uri uri = Uri.parse(url);

    http.Response res = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(res.body);

    return;
  }
}
