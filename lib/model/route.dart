import 'package:brummaps/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Route extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<Step>? steps;
  final String? duration;
  final int? distance;

  Route(
      {required this.id,
      required this.title,
      required this.description,
      required this.steps,
      required this.distance,
      this.duration});

  factory Route.fromJson(Map<String, dynamic> json, {bool fetchAll = true}) {
    return Route(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      steps: fetchAll ? null : (json["itinerarySteps"] as List)
          .map<Step>((e) => Step.fromJson(e["step"], order: int.parse(e["order"]) ))
          .toList()?..sort((a,b) => a.order!.compareTo(b.order!)),
      distance: json['distance'],
      duration: json['duration'],
    );
  }
  @override
  List<Object?> get props => [];
}
