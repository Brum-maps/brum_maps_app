 import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Step extends Equatable {

  String? imgReference;
  String? title;
  String? desc;
  LatLng? latLng;

  Step({this.imgReference, this.title, this.desc, this.latLng});

  factory Step.fromJson(Map<String, dynamic> json) {
    
    return Step();
  }

  @override
  List<Object?> get props => [imgReference, title, desc, latLng];

}