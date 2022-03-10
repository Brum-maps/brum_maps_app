import 'package:bloc/bloc.dart';
import 'package:brummaps/implementation/iroute_provider.dart';
import 'package:brummaps/mock/mock_routes_controller.dart';
import 'package:brummaps/model/model.dart';
import 'package:equatable/equatable.dart';

part 'last_routes_state.dart';

class LastRoutesCubit extends Cubit<LastRoutesState> {
  LastRoutesCubit({IRouteProvider? dataProvider}) : _iRouteProvider = dataProvider ?? MockRouteController(),
        super(LastRoutesState(
    status: LRouteStatus.initial,
    routes: [],
  ));
  final IRouteProvider _iRouteProvider;

  void fetch() {
    var routes = _iRouteProvider.fetchAll();
    print("routes in fetch cubit  ---> $routes");
    if(routes != null && routes.isNotEmpty) {
      emit(
        LastRoutesState(status: LRouteStatus.loaded, routes: routes)
      );
    } else {
      emit(
        LastRoutesState(status: LRouteStatus.empty)
      );
    }
  }
}
