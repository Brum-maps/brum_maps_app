part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  empty,
  loaded,
}
class HomeState extends Equatable {

  final HomeStatus status;

  HomeState({required this.status});
  @override
  List<Object> get props => [
    status
  ];
}
