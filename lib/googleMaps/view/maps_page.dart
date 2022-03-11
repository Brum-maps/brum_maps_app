import 'package:brummaps/googleMaps/cubit/google_maps_cubit.dart';
import 'package:brummaps/googleMaps/google_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapsPage extends StatefulWidget {
  static Page page() => const MaterialPage<Widget>(child: MapsPage());
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  double _opacity = 0;
  bool showItinary = true;
  String textButton = "Démarrer";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => GoogleMapsCubit()..laodSteps()),
      child: BlocBuilder<GoogleMapsCubit, GoogleMapsState>(
          builder: (context, state) {
        var steps = state.steps;
        if (steps == null) {
          return Container();
        }
        return Scaffold(
          body: Stack(
            // LatLng(48.849784, 2.392003)
            children: [
              GoogleMapsWidget(
                showItinary: showItinary,
                steps: steps,
                onClick: (value) {
                  setState(() {
                    textButton = "Fermer";
                    _opacity = 0;
                    showItinary = value;
                  });
                },
              ),
              if (showItinary)
                Scaffold(
                  backgroundColor: Colors.black.withOpacity(_opacity),
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () => textButton == "Fermer"
                          ? setState(() {
                              showItinary = false;
                            })
                          : Navigator.of(context).pop(),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: StepPage(
                    onScroll: (opacity) => setState(
                      () {
                        _opacity = opacity;
                      },
                    ),
                    textButton: textButton,
                    onClick: (value) {
                      setState(() {
                        showItinary = value;
                      });
                    },
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
