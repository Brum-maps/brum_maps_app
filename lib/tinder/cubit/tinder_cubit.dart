import 'package:brummaps/model/model.dart';
import 'package:brummaps/services/googleMaps/google_maps_service.dart';
import 'package:brummaps/services/stepsService/step_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'tinder_state.dart';

class TinderCubit extends Cubit<TinderState> {
  TinderCubit() : super(const TinderState.initial());

  final GoogleMapsService service = GoogleMapsService();
  final StepsService stepsService = StepsService.instance;

  Future getImageUrlFromReference(String reference) async {
    var imageUrl = await service.getImageUrlFromReference(reference);
    return imageUrl;
  }

  Future<void> getTinderCardList() async {
    List<Step> steps = [
      Step(
        title: "Arc de Triomphe",
        desc: "Ceci est l'arc de triomphe",
        latLng: const LatLng(48.859784, 2.402003),
      ),
      Step(
        title: "Arc de Triomphe",
        desc: "Ceci est l'arc de triomphe",
        latLng: const LatLng(48.869784, 2.412003),
      ),
      Step(
        title: "Arc de Triomphe",
        desc: "Ceci est l'arc de triomphe",
        latLng: const LatLng(48.879784, 2.422003),
      ),
      Step(
        title: "Arc de Triomphe",
        desc: "Ceci est l'arc de triomphe",
        latLng: const LatLng(48.889784, 2.432003),
      ),
      Step(
        title: "Arc de Triomphe",
        desc: "Ceci est l'arc de triomphe",
        latLng: const LatLng(48.899784, 2.442003),
      ),
    ];
    //await stepsService.getSteps(20);

    emit(TinderState.stepLoaded(steps));
  }
}
