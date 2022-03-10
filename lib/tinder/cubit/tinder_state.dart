part of 'tinder_cubit.dart';

enum TinderStatus { initial }

class TinderState extends Equatable {
  const TinderState(TinderStatus status);

  const TinderState.initial() : this(TinderStatus.initial);

  @override
  List<Object?> get props => [];
}
