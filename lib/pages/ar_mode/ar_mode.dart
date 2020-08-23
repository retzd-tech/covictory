import 'dart:math';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geolocator/geolocator.dart';

class ARMode extends StatefulWidget {
  ARMode({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ARModeState createState() => _ARModeState();
}

class ARMarker {
  double lat;
  double long;
}

class _ARModeState extends State<ARMode> {
  ArCoreController arCoreController;

   void _onArCoreViewCreated(ArCoreController _arCoreController) async {
    //make a limit 5 maybe
    var places = [
      {
        "id" : "abc",
        "latitude" : 4,
        "longitude" : -3,
        "name": "Upnormal Mojokerto",
      },
      {
        "id": "def",
        "latitude" : -8,
        "longitude" : 5,
        "name": "Upnormal Surabaya",
      }
    ];
    arCoreController = _arCoreController;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
//    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    for (var i = 0; i < places.length; i++) {
//      var random = new Random();
//      var dangerousIndex = random. nextInt(10);
//      _addMarker(arCoreController, places[i], dangerousIndex);
//    }

     //Already setup Google Cloud account to access Google Maps API and get the Json of Places near the user
     //need more time to integrate with Google Maps API data for Places

    _addMarker(arCoreController, 3.0, -5.0, 5, "Upnormal Cafe");
    _addMarker(arCoreController,-3.0, -7.0, 2, "Sunrise Mall");
    _addMarker(arCoreController, 1.0, 5.5, 9, "Central Square");
    _addMarker(arCoreController, 7.0, 3.0, 4, "Warung Kopi Joss");
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('$name')),
    );
  }

  void _addMarker(ArCoreController _arCoreController, covariant latitude, covariant longitude,covariant dangerousIndex, covariant placeName) {
     print('latitude');
     print(latitude);
     var material = ArCoreMaterial(
      color: Colors.green,
    );
    var markerNode;
    var message = '';
      if (dangerousIndex <= 3) {
        material = ArCoreMaterial(
          color: Colors.green,
        );
        message = 'Wilayah ini tidak memiliki resiko penularan yang tinggi, untuk berjaga - jaga tetap patuhi protokol kesehatan ya.';

        markerNode = ArCoreReferenceNode(
          name: placeName + ", " + message,
          obcject3DFileName: 'green_marker.sfb',
          position: vector.Vector3(latitude, 1, longitude),
        );
      }
    if (dangerousIndex >= 4 && dangerousIndex <= 7) {
      material = ArCoreMaterial(
        color: Colors.yellow,
      );
      message = 'Wilayah ini memiliki resiko penularan yang sedang, jika tidak terlalu darurat, lebih baik hindari tempat ini jika tempat ini ramai ya.';

      markerNode = ArCoreReferenceNode(
        name:  placeName + ", " + message,
        obcject3DFileName: 'yellow_marker.sfb',
        position: vector.Vector3(latitude, 1, longitude),
      );
    }
    if (dangerousIndex >= 8) {
      material = ArCoreMaterial(
        color: Colors.red,
      );
      message = 'Wilayah ini memiliki resiko penularan yang sangat tinggi ! dimohon untuk berada di sekitar wilayah ini jika memungkinkan ya.';

      markerNode = ArCoreReferenceNode(
        name:  placeName + ", " + message,
        obcject3DFileName: 'red_marker.sfb',
        position: vector.Vector3(latitude, 1, longitude),
      );
    }
    _arCoreController.addArCoreNode(markerNode);
  }

  @override
  void dispose() {
    try {
      arCoreController.dispose();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ArCoreView(
        enableTapRecognizer: true,
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}
