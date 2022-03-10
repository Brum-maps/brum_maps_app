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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            // LatLng(48.849784, 2.392003)
            children: [
              GoogleMapsWidget(
                // startLatitude: 48.849784,
                // startLongitude: 2.392003,
                // destinationLatitude: 48.859784,
                // destinationLongitude: 2.402003,
                steps: steps,
              ),
              // Scaffold(
              //   backgroundColor: Colors.black.withOpacity(_opacity),
              //   appBar: AppBar(
              //     leading: IconButton(
              //       icon: const Icon(
              //         Icons.close_rounded,
              //         color: Colors.black,
              //       ),
              //       onPressed: () => Navigator.of(context).pop(),
              //     ),
              //     backgroundColor: Colors.transparent,
              //     elevation: 0,
              //   ),
              //   body: StepPage(
              //     onScroll: (opacity) => setState(() {
              //       _opacity = opacity;
              //     }),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
