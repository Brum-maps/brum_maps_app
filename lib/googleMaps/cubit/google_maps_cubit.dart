import 'package:brummaps/model/step.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(const GoogleMapsState.initial());

  Future<void> laodSteps() async {
 
    
    
    // emit(GoogleMapsState.stepLoaded(steps));
  }
}
