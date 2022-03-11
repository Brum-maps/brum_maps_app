import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:brummaps/model/step.dart' as step;

class GoogleMapsWidget extends StatefulWidget {
  final List<step.Step> steps;
  final void Function(bool) onClick;
  final bool showItinary;

  const GoogleMapsWidget(
      {Key? key,
      required this.steps,
      required this.onClick,
      required this.showItinary})
      : super(key: key);

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  GoogleMapController? mapController;

  // Object for PolylinePoints
  late PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  Set<Marker> markers = {};

  String _currentAddress = "";
  String _startAddress = "";

  late Position _currentPosition;

  final startAddressController = TextEditingController();

  Future<void> _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        // For moving the camera to current location
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddress() async {
    try {
      // Places are retrieved using the coordinates
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      // Taking the most probable result
      Placemark place = p[0];

      setState(() {
        // Structuring the address
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        // Update the text of the TextField
        startAddressController.text = _currentAddress;

        // Setting the user's present location as the starting address
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    for (int i = 0; i < widget.steps.length - 1; i++) {
      var _step = widget.steps[i];
      var _nextStep = widget.steps[i + 1];
      if (i + 1 < widget.steps.length) {
        String startCoordinatesString =
            '(${_step.latLng!.latitude}, ${_step.latLng!.longitude})';
        // String destinationCoordinatesString =
        //     '(${_nextStep.latLng!.latitude}, ${_nextStep.latLng!.latitude})';

        // Start Location Marker
        Marker startMarker = Marker(
          markerId: MarkerId(startCoordinatesString),
          position: LatLng(_step.latLng!.latitude, _step.latLng!.longitude),
          infoWindow: InfoWindow(
            title: _step.title,
            snippet: _step.desc,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyB-JOAag0t_pzNaZusRiOcG6-Xx8To60N8", // Google Maps API Key
          PointLatLng(_step.latLng!.latitude, _step.latLng!.longitude),
          PointLatLng(_nextStep.latLng!.latitude, _nextStep.latLng!.longitude),
          // PointLatLng(startLatitude, startLongitude),
          // PointLatLng(destinationLatitude, destinationLongitude),
          travelMode: TravelMode.driving,
        );
        // Adding the coordinates to the list
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        }

        markers.add(startMarker);

        if (i == widget.steps.length - 2) {
          String destinationCoordinatesString =
              '(${_nextStep.latLng!.latitude}, ${_nextStep.latLng!.longitude})';

          Marker destinationMarker = Marker(
            markerId: MarkerId(destinationCoordinatesString),
            position:
                LatLng(_nextStep.latLng!.latitude, _nextStep.latLng!.longitude),
            infoWindow: InfoWindow(
              title: _nextStep.title,
              snippet: _nextStep.desc,
            ),
            icon: BitmapDescriptor.defaultMarker,
          );

          markers.add(destinationMarker);
        }
      }
    }

    // Generating the list of coordinates to be used for
    // drawing the polylines

    // Defining an ID
    PolylineId id = const PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    setState(() {
      polylines[id] = polyline;
    });

    double miny = (startLatitude <= destinationLatitude)
        ? startLatitude
        : destinationLatitude;
    double minx = (startLongitude <= destinationLongitude)
        ? startLongitude
        : destinationLongitude;
    double maxy = (startLatitude <= destinationLatitude)
        ? destinationLatitude
        : startLatitude;
    double maxx = (startLongitude <= destinationLongitude)
        ? destinationLongitude
        : startLongitude;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

// Accommodate the two locations within the
// camera view of the map
    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    );
  }

  @override
  void initState() {
    _createPolylines(
        widget.steps[0].latLng!.latitude,
        widget.steps[0].latLng!.longitude,
        widget.steps[widget.steps.length - 1].latLng!.latitude,
        widget.steps[widget.steps.length - 1].latLng!.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: widget.showItinary
            ? null
            : Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    bool hasToClose = false;
                    showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        content: const Text(
                            "Voulez-vous vraiment quitter votre parcours ?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              hasToClose = true;
                              Navigator.of(context).popUntil((route) {
                                return route.isFirst;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                "Oui",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text("Non",
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                    ).then((value) =>
                        hasToClose ? Navigator.of(context).pop() : null);
                  },
                ),
              ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(
                Icons.info_outline_rounded,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          GoogleMap(
            markers: Set<Marker>.from(markers),
            polylines: Set<Polyline>.of(polylines.values),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _getCurrentLocation();
            },
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.7)),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.route_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      widget.onClick(true);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.location_on_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      var firstStep = widget.steps[0].latLng;
                      var lastStep =
                          widget.steps[widget.steps.length - 1].latLng;
                      double miny = (firstStep!.latitude <= lastStep!.latitude)
                          ? firstStep.latitude
                          : lastStep.latitude;
                      double minx = (firstStep.longitude <= lastStep.longitude)
                          ? firstStep.longitude
                          : lastStep.longitude;
                      double maxy = (firstStep.latitude <= lastStep.latitude)
                          ? lastStep.latitude
                          : firstStep.latitude;
                      double maxx = (firstStep.longitude <= lastStep.longitude)
                          ? lastStep.longitude
                          : firstStep.longitude;

                      double southWestLatitude = miny;
                      double southWestLongitude = minx;

                      double northEastLatitude = maxy;
                      double northEastLongitude = maxx;

                      // Accommodate the two locations within the
                      // camera view of the map
                      mapController?.animateCamera(
                        CameraUpdate.newLatLngBounds(
                          LatLngBounds(
                            northeast:
                                LatLng(northEastLatitude, northEastLongitude),
                            southwest:
                                LatLng(southWestLatitude, southWestLongitude),
                          ),
                          100.0,
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.location_searching_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _getCurrentLocation();
                      mapController?.animateCamera(
                        CameraUpdate.newLatLng(
                          LatLng(_currentPosition.latitude,
                              _currentPosition.longitude),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
