import 'package:covictory_ar/model/nearby_places.dart';
import 'package:covictory_ar/services/google_places.dart';
import 'package:flutter/material.dart';

class LocationListPage extends StatefulWidget {
  @override
  _LocationListPageState createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  Future<NearbyPlaces> futureNearbyPlaces;

  @override
  void initState() {
    super.initState();
    futureNearbyPlaces = fetchGooglePlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NearbyPlaces>(
        future: futureNearbyPlaces,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data.results[index].name),
                    subtitle: Text(snapshot.data.results[index].name),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
