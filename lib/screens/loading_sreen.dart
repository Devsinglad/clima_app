import 'dart:convert';

import 'package:clima_app/screens/location_screen.dart';
import 'package:clima_app/services/locate.dart';
import 'package:clima_app/services/weather.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../services/data.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    try {
      WeatherModel wedamodel = WeatherModel();
      var weatherData = await wedamodel.getweatherLocaion();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LocationScreen(
            locationWeather: weatherData,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SpinKitDoubleBounce(
      color: Colors.red,
      size: 100,
    ));
  }
}
