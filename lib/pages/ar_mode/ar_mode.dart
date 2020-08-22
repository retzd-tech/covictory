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
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    for (var i = 0; i < places.length; i++) {
//      var random = new Random();
//      var dangerousIndex = random. nextInt(10);
//      _addSphere(arCoreController, places[i], dangerousIndex);
//    }
    _addSphere(arCoreController, places[0] ,5);
    _addCube(arCoreController);
    _addCylinder(arCoreController);
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('$name')),
    );
  }

  void _addSphere(ArCoreController _arCoreController, covariant places, covariant dangerousIndex) {
    var material = ArCoreMaterial(
      color: Colors.green,
    );
    var message = '';
      if (dangerousIndex <= 3) {
        material = ArCoreMaterial(
          color: Colors.green,
        );
        message = 'Wilayah ini tidak memiliki resiko penularan yang tinggi, untuk berjaga - jaga tetap patuhi protokol kesehatan ya.';
      }
    if (dangerousIndex >= 4 && dangerousIndex <= 7) {
      material = ArCoreMaterial(
        color: Colors.yellow,
      );
      message = 'Wilayah ini memiliki resiko penularan yang sedang, jika tidak terlalu darurat, lebih baik hindari tempat ini jika tempat ini ramai ya.';
    }
    if (dangerousIndex >= 8) {
      material = ArCoreMaterial(
        color: Colors.red,
      );
      message = 'Wilayah ini memiliki resiko penularan yang sangat tinggi ! dimohon untuk berada di sekitar wilayah ini jika memungkinkan ya.';
    }
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.4,
    );
    final node = ArCoreNode(
      shape: sphere,
      name: places.name + message,
      position: vector.Vector3(0.5, 1, -7),
    );
    _arCoreController.addArCoreNode(node);
  }

  void _addCylinder(ArCoreController _arCoreController) {
    final material = ArCoreMaterial(color: Colors.green, reflectance: 1);
    final cylinder = ArCoreCylinder(
      materials: [material],
      radius: 0.3,
      height: 0.1,
    );
    final node = ArCoreNode(
      shape: cylinder,
      position: vector.Vector3(-0.3, -1, -1.0),
    );
    _arCoreController.addArCoreNode(node);
  }

  _addCube(ArCoreController _arCoreController) {
    final material = ArCoreMaterial(color: Colors.pink, metallic: 1);
    final cube =
        ArCoreCube(materials: [material], size: vector.Vector3(0.5, 0.5, 0.5));
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(0.5, -3, -3),
    );
    _arCoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
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
