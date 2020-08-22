import 'dart:convert';

import 'package:covictory_ar/model/nearby_places.dart';
import 'package:http/http.dart' as http;

Future<NearbyPlaces> fetchGooglePlaces() async {
  final response = await http.get(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1500&type=restaurant&keyword=cruise&key=AIzaSyCTSzieq7QwcYmAQ4JkpLiHzrsTrLGoWTI');

  if (response.statusCode == 200) {
    return NearbyPlaces.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
