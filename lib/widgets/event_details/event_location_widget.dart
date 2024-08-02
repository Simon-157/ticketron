import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class EventLocationSection extends StatefulWidget {
  final String location;
  final double latitude;
  final double longitude;

  const EventLocationSection({
    super.key,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  @override
  _EventLocationSectionState createState() => _EventLocationSectionState();
}

class _EventLocationSectionState extends State<EventLocationSection> {
  late GoogleMapController mapController;
  LocationData? currentLocation;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
      _getPolyline();
      setState(() {});
    } catch (e) {
      print('Error getting current location: $e');
    }
  }


  Future<void> _getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyCaJDhsrVKwuIwUK6uFfhX_l3HXnMHdTLs',
      request: PolylineRequest(
      origin:PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      destination:PointLatLng(widget.latitude, widget.longitude),
      mode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: widget.location)],
    ));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('polyline'),
          color: Colors.blue,
          points: polylineCoordinates,
        ),
      );
    });
  }

  void _showDirectionsModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Directions to ${widget.location}',
                style: Constants.heading3,
              ),
              const SizedBox(height: Constants.paddingSmall),
              const Text(
                'From: Your Location',
                style: Constants.bodyText,
              ),
              const SizedBox(height: Constants.paddingSmall),
              Text(
                'To: ${widget.location}',
                style: Constants.bodyText,
              ),
              const SizedBox(height: Constants.paddingSmall),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _getPolyline();
                },
                child: const Text('Show Directions'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: Constants.heading3,
        ),
        const SizedBox(height: Constants.paddingSmall),
        Text(
          widget.location,
          style: Constants.bodyText,
        ),
        const SizedBox(height: Constants.paddingSmall),
        Container(
          margin: const EdgeInsets.only(bottom: 150.0),
          height: 200,
          color: Colors.grey[200],
          child: GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 14.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('eventLocation'),
                position: LatLng(widget.latitude, widget.longitude),
                infoWindow: InfoWindow(
                  title: widget.location,
                  onTap: _showDirectionsModal,
                ),
              ),
            },
            polylines: polylines,
          ),
        ),
      ],
    );
  }
}
