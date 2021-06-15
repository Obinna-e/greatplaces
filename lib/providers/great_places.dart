import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [...items];
  }
  /* return a copy of item so if you change the list where items is gotten from
  it wouldn't change the _items list in the class. If changed from outside notify
  listeners won't be triggered so this prevents that */
}
