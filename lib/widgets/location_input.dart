import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_config/flutter_config.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    ); //as this is async, can get selected location when page is popped
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.location_on),
                label: Text('Current Location'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                label: Text('Select on Map'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
