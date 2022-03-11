import 'package:brummaps/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Route extends Equatable {
  final String title;
  final String description;
  final List<Step> steps;
  final String? duration;
  final int? distance;

  Route({required this.title, required this.description, required this.steps, required this.distance, this.duration});

  factory Route.fromJson(Map<String, dynamic> json){
    return Route(
      title: json['name'],
      description: json['description'],
      steps: [],
      distance: json['distance'],
      duration: json['duration'],
    );
  }
  @override
  List<Object?> get props => [];

}