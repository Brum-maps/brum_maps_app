import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brummaps/implementation/iroute_provider.dart';
import 'package:brummaps/model/model.dart';
import 'package:brummaps/services/web/route_services.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({IRouteProvider? dataProvider})
      : _routeController = dataProvider ?? LocalRouteController(),
        super(const HomeState(
    status: HomeStatus.initial,
    routes: []
  ));

  final IRouteProvider _routeController;
  void fetch() async {
    var routes = await _routeController.fetchAll();
    if(routes!.isNotEmpty ) {
      emit(
        HomeState(status: HomeStatus.loaded, routes: routes)
      );
    } else  {
     emit(
      const HomeState(status: HomeStatus.empty, routes: [])
     );
    }
  }
}
