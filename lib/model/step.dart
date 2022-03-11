import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Step extends Equatable {
  String? id;
  String? imgUrl;
  String? title;
  String? desc;
  bool isLiked;
  LatLng? latLng;

  Step(
      {this.id,
      this.imgUrl,
      this.title,
      this.desc,
      this.latLng,
      this.isLiked = false});

  factory Step.fromJson(Map<String, dynamic> json) {
    var id = json['id'] as String?;
    var title = json['name'] as String?;
    var desc = json['description'] as String?;
    var imgReference = json['image'] as String?;
    var lat = json['latitude'] as double;
    var lng = json['longitude'] as double;

    var latLng = LatLng(lat, lng);

    return Step(
        title: title, desc: desc, imgUrl: imgReference, latLng: latLng, id: id);
  }

  @override
  List<Object?> get props => [imgUrl, title, desc, latLng];
}
