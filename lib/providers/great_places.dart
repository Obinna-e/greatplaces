import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
  /* return a copy of item so if you change the list where items is gotten from
  it wouldn't change the _items list in the class. If changed from outside notify
  listeners won't be triggered so this prevents that */

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: null,
        image: pickedImage);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path, //storing path because can't store img in db
    });
    //keys in map have to match field names in CREATE TABLE
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            /*Need image here not path so used File to create a file from
               image path and load file to memory*/
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
