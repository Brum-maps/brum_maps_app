import 'package:brummaps/model/step.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(const GoogleMapsState.initial());

  Future<void> laodSteps() async {
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
    emit(GoogleMapsState.stepLoaded(steps));
  }
}
