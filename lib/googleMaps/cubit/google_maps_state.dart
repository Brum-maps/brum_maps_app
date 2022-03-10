part of 'google_maps_cubit.dart';

enum GoogleMapsStatus { initial, loading, stepLoaded }

class GoogleMapsState extends Equatable {
  final List<Step>? steps;

  const GoogleMapsState(GoogleMapsStatus status, {this.steps});

  const GoogleMapsState.initial() : this(GoogleMapsStatus.initial);

  const GoogleMapsState.stepLoaded(List<Step> steps) : this(GoogleMapsStatus.stepLoaded, steps: steps);

  @override
  List<Object?> get props => [];
}
