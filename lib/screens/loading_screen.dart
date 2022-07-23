import '../screens/location_screen.dart';
import '../utilities/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getGeoLocationData() async {
    WeatherModel weather = WeatherModel();
    final data = await weather.getWeatherData();

    if (data != "failed") {
      // var decodedData = jsonDecode(data);
      // int temperature = decodedData["main"]["temp"];
      // int condition = decodedData["weather"][0]["id"];
      // String cityName = decodedData["name"];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            weatherData: data,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGeoLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
