import 'package:brummaps/services/googleMaps/google_maps_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GoogleMapsService service;

  setUp(() {
    service = GoogleMapsService();
  });

  test("get image response", () async {
    String url = await service.getImageUrlFromReference(
        "Aap_uEBOa0QktDNLLmoxQreB_rIoWfB0A7Mwax-OIYdGkdi6MrbV5Tk_R4vneSr3n0xrWfOIOQHp8X1tcjq1-jc03NlATOPTh8oeHmqF_-PDfIwpk_8D04r5A6f-l5gDOa2DF4g0VHn4Ew_Y-ZPsGEkm047juzsLrZ12J_ahKBuHz4NEA32D");
    expect(url, "matcher");
  });
}
