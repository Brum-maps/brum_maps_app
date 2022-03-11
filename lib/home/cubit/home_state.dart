part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  empty,
  loaded,
}
class HomeState extends Equatable {
  final HomeStatus status;
  final List<Route> routes;

  const HomeState({required this.status, required this.routes});
  @override
  List<Object> get props => [
    status,
    routes
  ];
}
