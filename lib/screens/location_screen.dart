import 'package:clima_app/screens/city_screen.dart';
import 'package:clima_app/services/weather.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? weatherIcon;
  String? cityName;
  int? temperature;
  String? message;

  @override
  void initState() {
    // TODO: implement initState
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temperature = 0;
      cityName = "";
      message = 'error in retrieving data';
      return;
    }
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    var condition = weatherData['weather'][0]['id'];
    weatherIcon = weather.getWeatherIcon(condition);
    message = weather.getMessage(temperature!);
    setState(() {});
    print(temperature);
    print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              'images/location_background.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData = await weather.getweatherLocaion();
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CityScreen()));
                      print(typedName);
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$temperature°c',
                    style: kTempTextStyle,
                  ),
                  Text(
                    weatherIcon!,
                    style: kConditionTextStyle,
                  ),
                ],
              ),
              Text(
                "$message in $cityName",
                textAlign: TextAlign.left,
                style: kMessageTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
