import 'package:brummaps/model/model.dart';
import 'package:equatable/equatable.dart';

class Route extends Equatable {
  final String title;
  final String description;
  final List<Step> steps;

  Route({required this.title, required this.description, required this.steps});

  
  @override
  List<Object?> get props => [];

}