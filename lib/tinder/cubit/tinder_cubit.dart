import 'package:brummaps/model/model.dart';
import 'package:brummaps/services/googleMaps/google_maps_service.dart';
import 'package:brummaps/services/stepsService/step_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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

  List<Step> sortedStep(List<Step> lastStep) {
    if (lastStep.isEmpty) return [];
    Step current = lastStep[0];
    List<double> sorted = [];
    for (int i = 1; i < lastStep.length; i++) {
      var next = lastStep[i];

      double distanceInMeters = Geolocator.bearingBetween(
        current.latLng!.latitude,
        current.latLng!.longitude,
        next.latLng!.latitude,
        next.latLng!.longitude,
      );

      sorted.add(distanceInMeters);
    }
    double distTmp = 999999;
    int minIndex = 0;
    for (double s in sorted) {
      if (s < distTmp) {
        distTmp = s;
        minIndex = sorted.indexOf(s);
      }
    }

    return [lastStep[minIndex], ...sortedStep(lastStep..removeAt(minIndex))];
  }

  List<Step> sendItinary(List<Step> steps) {
    Map<String, dynamic> json = {
      "name": "test",
      "description": "",
      "isActive": true,
      "isPublic": false,
      "stepToSave":
          steps.map((e) => {"id": e.id, "order": steps.indexOf(e)}).toList(),
    };

    // List result = [];
    // List tmp = List.from(steps);
    // for (int j = 0; j < tmp.length; j++) {
    //   var current = tmp[j];
    //   List<double> sorted = [];
    //   for (int i = j + 1; i < steps.length; i++) {
    //     var next = steps[i];

    //     double distanceInMeters = await Geolocator.bearingBetween(
    //       current.latLng!.latitude,
    //       current.latLng!.longitude,
    //       next.latLng!.latitude,
    //       next.latLng!.longitude,
    //     );

    //     sorted.add(distanceInMeters);
    //   }
    //   double distTmp = 999999;
    //   int minIndex = 0;
    //   for (double s in sorted) {
    //     if (s < distTmp) {
    //       distTmp = s;
    //       minIndex = sorted.indexOf(s);
    //     }
    //   }

    //   result.add(steps[minIndex]);
    stepsService.sendSteps(json);

    return sortedStep(steps);

    // var sortedStep =
  }

  Future<void> getTinderCardList({bool reload = false}) async {
    if (reload) emit(const TinderState.initial());

    var steps = await stepsService.getSteps(20);

    emit(TinderState.stepLoaded(steps));
  }
}
