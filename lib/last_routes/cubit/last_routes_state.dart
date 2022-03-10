part of 'last_routes_cubit.dart';

enum LRouteStatus {
  initial,
  loading,
  empty,
  loaded
}
class LastRoutesState extends Equatable {
  LastRoutesState({required this.status, this.routes});
   final LRouteStatus status;
   final List<Route>? routes;
  @override
  List<Object?> get props => [
    status,
    routes
  ];
}
