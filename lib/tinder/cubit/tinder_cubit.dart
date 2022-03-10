import 'package:brummaps/model/model.dart';
import 'package:brummaps/services/googleMaps/google_maps_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'tinder_state.dart';

class TinderCubit extends Cubit<TinderState> {
  TinderCubit() : super(const TinderState.initial());

  final GoogleMapsService service = GoogleMapsService();

  Future getImageUrlFromReference(String reference) async {
    var imageUrl = await service.getImageUrlFromReference(reference);
    return imageUrl;
  }

  Future<Step> getTinderCardList() async {
    return Step();
  }
}
