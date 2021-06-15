import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
  /*longitude and latitude are needed to tell a location. 
  address however is human readable so isn't required*/
}

class Place {
  final String id;
  final String title;
  final Place location;
  final File image; //from dart:io

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
