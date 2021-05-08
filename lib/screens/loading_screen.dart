import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '407b0ac7dca0f90ff6f97a96fdaf2856';
double latitude;
double longitude;

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
    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://samples.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'),
    );
    if (response.statusCode == 200) {
      String data = response.body;

      var temperature = jsonDecode(data)['main']['temp'];
      print(temperature);

      var cityName = jsonDecode(data)['name'];
      print(cityName);

      var condition = jsonDecode(data)['weather'][0]['id'];
      print(condition);
    } else {
      print(response.statusCode.toString() + ' error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
