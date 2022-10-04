import '../screens/loading_sreen.dart';
import 'data.dart';
import 'locate.dart';

const ApiKey = '129c8cce477862a66f76994157122ccd';

class WeatherModel {
  var openUrl = "http://api.openweathermap.org/data/2.5/weather";

  Future<dynamic> getCityWeather(String cityName) async {
    Data data = Data(url: '$openUrl?q=$cityName&appid=$ApiKey&units=metric');
    var weatherData = await data.getData();
    return weatherData;
  }

  Future<dynamic> getweatherLocaion() async {
    Locate location = Locate();
    await location.getCurrentLocation();

    Data data = Data(
      url:
          '$openUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$ApiKey&units=metric',
    );
    var weatherData = await data.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
