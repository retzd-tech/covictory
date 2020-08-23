import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARMode extends StatefulWidget {
  ARMode({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ARModeState createState() => _ARModeState();
}

class _ARModeState extends State<ARMode> {
  ArCoreController arCoreController;

  void _onArCoreViewCreated(ArCoreController _arCoreController) {
    arCoreController = _arCoreController;
    _addSphere(arCoreController);
    _addCube(arCoreController);
    _addCylinder(arCoreController);
  }

  void _addSphere(ArCoreController _arCoreController) {
    final material = ArCoreMaterial(
      color: Colors.deepPurple,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, -0.3, -1),
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
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}
