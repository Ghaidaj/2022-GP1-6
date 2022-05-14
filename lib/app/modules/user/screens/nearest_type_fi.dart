import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PlaceView extends StatelessWidget {
  PlaceView({required this.title, required this.placeType}) : super();
  String title;
  PlaceTypes placeType;

  late PlaceViewModel viewModel;
  late BuildContext _context;

  final String _deniedLocationMessage = "Denied your location";

  @override
  Widget build(BuildContext context) {
    _context = context;
    return ChangeNotifierProvider<PlaceViewModel>(
        create: (context) => PlaceViewModel(placeType),
        builder: (context, child) {
          viewModel = Provider.of<PlaceViewModel>(context);
          return Scaffold(appBar: AppBar(backgroundColor: Color(0xff56888F)  ,title: Text(title)), body: _content());
        });
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: viewModel.isLoading
          ? [viewModel.loading()]
          : viewModel.gpsManager.userPosition != null
              ? [_googleMap(), _placeDetails()]
              : [
                  NoContent(
                    message: _deniedLocationMessage,
                  )
                ],
    );
  }

  Widget _placeDetails() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
          padding: EdgeInsets.all(10),
          physics: PageScrollPhysics(),
          itemCount: viewModel.places.length,
          separatorBuilder: (context, int index) => Divider(color: Colors.grey),
          itemBuilder: (context, int index) {
            return _placeItem(viewModel.places[index]);
          }),
    ));
  }

  Widget _placeItem(PlaceModel place) {
    return Wrap(
      spacing: 10,
      direction: Axis.vertical,
      children: [
        FittedBox(
          child: Text(
            place.name,
            style: Theme.of(_context).textTheme.subtitle2,
          ),
        ),
        Text(place.isOpen ? "Open" : "Close"),
        Text("${(place.distance / 1000).toStringAsFixed(2)} km"),
        Wrap(
          spacing: 20,
          children: [
            Text("${place.userRatingCount ?? '-'} Reviews"),
            Text("${place.rating ?? "-"} Rating")
          ],
        ),
      ],
    );
  }

  Widget _googleMap() {
    return Expanded(
      child: GoogleMap(
        markers: viewModel.markers,
        onMapCreated: (controller) async {
          viewModel.onMapCreated(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(viewModel.gpsManager.userPosition!.latitude,
              viewModel.gpsManager.userPosition!.longitude),
          zoom: 13.0,
        ),
      ),
    );
  }
}

class PlaceViewModel extends BaseProvider with PlaceService {
  late GpsManager gpsManager;
  late Completer<GoogleMapController> _controller;
  late PlaceTypes _placeType;

  Set<Marker> markers = Set();
  List<PlaceModel> places = [];
  PlaceViewModel(PlaceTypes placeType) {
    _placeType = placeType;
    gpsManager = GpsManager();
    _controller = Completer();
    init();
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> init() async {
    checkLoading();

    await gpsManager.getCoordinates();
    if (gpsManager.userPosition != null) {
      await _getPlaces();
      await _addMarkers();
    }

    checkLoading();
  }

  Future<void> _getPlaces() async {
    places = await getPlacesFromGoogle(
        lat: gpsManager.userPosition!.latitude,
        long: gpsManager.userPosition!.longitude,
        placeType: _placeType);
  }

  Future<void> _addMarkers() async {
    places.forEach((place) async {
      Marker marker = Marker(
          markerId: MarkerId(place.name),
          draggable: false,
          infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng));
      place.distance = await gpsManager.calculateDistance(
          place.geometry.location.lat, place.geometry.location.lng);
      markers.add(marker);
    });
  }
}

enum PlaceTypes {
  hospital,
  pharmacy,
  police,
}

class GeometryModel {
  final LocationModel location;

  GeometryModel({required this.location});

  GeometryModel.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = LocationModel.fromJson(parsedJson['location']);
}

class LocationModel {
  final double lat;
  final double lng;

  LocationModel({required this.lat, required this.lng});

  LocationModel.fromJson(Map<dynamic, dynamic> parsedJson)
      : lat = parsedJson['lat'],
        lng = parsedJson['lng'];
}

class PlaceModel {
  final String name;
  final double? rating;
  final int? userRatingCount;
  final String? vicinity;
  final GeometryModel geometry;
  final bool isOpen;
  double distance = 0;
  PlaceModel(
      {required this.geometry,
      required this.name,
      this.rating,
      this.userRatingCount,
      this.vicinity,
      required this.isOpen});

  PlaceModel.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)
            ? parsedJson['rating'].toDouble()
            : null,
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total']
            : null,
        vicinity = parsedJson['vicinity'],
        geometry = GeometryModel.fromJson(
          parsedJson['geometry'],
        ),
        isOpen = (parsedJson['opening_hours'] != null)
            ? parsedJson['opening_hours']['open_now'] as bool
            : false;
}

class PlaceService {
  // we have to change Google Api Key and enable Google Place Apı, Android Map SDK, Billing Account after change the account
  final apiKey = 'AIzaSyBoC7rIaEmmGp5joPCZe3Bx21Ij1pwWReE';
  Future<List<PlaceModel>> getPlacesFromGoogle(
      {required double lat,
      required double long,
      required PlaceTypes placeType}) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&type=${placeType.name}&rankby=distance&key=$apiKey'));

    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => PlaceModel.fromJson(place)).toList();
  }
}

abstract class BaseProvider with ChangeNotifier {
  bool isLoading = false;

  void checkLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Widget loading() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              height: 120,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Please Waiting..")
                ],
              ))
        ],
      ),
    );
  }
}

class GpsManager {
  Position? userPosition;
  Future<void> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> getCoordinates() async {
    await checkPermission();
    userPosition = await Geolocator.getCurrentPosition();
  }

  Future<double> calculateDistance(
      double endLatitude, double endLongitude) async {
    return await Geolocator.distanceBetween(userPosition!.latitude,
        userPosition!.longitude, endLatitude, endLongitude);
  }
}

class NoContent extends StatelessWidget {
  const NoContent({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Center(
            child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 24,
              ),
              Text(message),
            ]),
      ),
    )));
  }
}
