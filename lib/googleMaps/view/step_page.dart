import 'dart:developer';

import 'package:brummaps/googleMaps/cubit/google_maps_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepPage extends StatelessWidget {
  final void Function(double opacity)? onScroll;
  const StepPage({Key? key, this.onScroll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleMapsCubit()..laodSteps(),
      child: BlocBuilder<GoogleMapsCubit, GoogleMapsState>(
          builder: (context, state) {
        var steps = state.steps;
        if (steps == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            var pixels = notification.metrics.pixels;
            if (onScroll != null) {
              if (pixels >= 0 && pixels <= 200) {
                onScroll!(pixels / 800);
              } else if (pixels < 0) {
                onScroll!(0);
              } else {
                onScroll!(0.25);
              }
            }

            return true;
          },
          child: ListView.builder(
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (index == 0)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                  if (index != 0)
                    Container(
                      height: 40,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        // border: Border.symmetric(vertical: BorderSide()),
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(steps[index].title ?? ""),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
    // ListView.builder(itemBuilder: itemBuilder);
  }
}