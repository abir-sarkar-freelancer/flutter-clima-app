import '../location_data.dart';
import '../services/network_service.dart';

const apiKey = "b4cf4808b59a01a2d6a7d4c3b80d77f5";
const weatherUrl = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<String> getCityData(String cityName) async {
    String uri = "$weatherUrl?q=$cityName&appid=$apiKey&units=metric";
    NetWorkService newService = NetWorkService(uri: uri);
    var data = await newService.getData();

    return data;
  }

  Future<String> getWeatherData() async {
    Location location = Location();

    double latitude;
    double longitude;
    try {
      await location.getCurrentLocation();
      latitude = location.latitude;
      longitude = location.longitude;
    } catch (e) {
      latitude = 0;
      longitude = 0;
    }

    String uri =
        "$weatherUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";

    NetWorkService newService = NetWorkService(uri: uri);
    var data = await newService.getData();

    return data;
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
