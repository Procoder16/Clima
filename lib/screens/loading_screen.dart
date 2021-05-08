import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22'),
    );
    if (response.statusCode == 200) {
      String data = response.body;

      var longitude = jsonDecode(data)['coord']['lon'];
      print(longitude);

      var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      print(weatherDescription);
    } else {
      print(response.statusCode.toString() + ' error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
