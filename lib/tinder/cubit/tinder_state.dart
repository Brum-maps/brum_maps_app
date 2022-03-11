part of 'tinder_cubit.dart';

enum TinderStatus { initial, loading, stepLoaded }

class TinderState extends Equatable {
  final List<Step>? steps;

  const TinderState(TinderStatus status, {this.steps});

  const TinderState.initial() : this(TinderStatus.initial);

  const TinderState.stepLoaded(List<Step> steps) : this(TinderStatus.stepLoaded, steps: steps);

  @override
  List<Object?> get props => [];
}
