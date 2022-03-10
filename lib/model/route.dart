import 'package:brummaps/model/model.dart';
import 'package:equatable/equatable.dart';

class Route extends Equatable {
  final String title;
  final String description;
  final List<Step> steps;
  final int duration;
  final int distance;

  Route({required this.title, required this.description, required this.steps, required this.distance, required this.duration});

  
  @override
  List<Object?> get props => [];

}