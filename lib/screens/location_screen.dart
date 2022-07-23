import 'package:clima_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../utilities/constants.dart';
import '../utilities/weather.dart';

class LocationScreen extends StatefulWidget {
  final String weatherData;
  const LocationScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  int condition = 0;
  String cityName = "city";
  String weatherIcon = "";
  String weatherMessage = "";
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(jsonDecode(widget.weatherData));
  }

  void updateUI(dynamic decodedData) {
    temperature = decodedData["main"]["temp"].round();

    condition = decodedData["weather"][0]["id"];
    cityName = decodedData["name"];
    weatherIcon = weather.getWeatherIcon(condition);
    weatherMessage = weather.getMessage(temperature.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/location_background.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstATop),
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
                FlatButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.near_me,
                    size: 50.0,
                  ),
                ),
                FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const CityScreen()),
                        ),
                      );

                      WeatherModel newWeather = WeatherModel();
                      var data = await newWeather.getCityData(typedName);
                      setState(() {
                        updateUI(jsonDecode(data));
                      });
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    temperature.toString(),
                    style: kTempTextStyle,
                  ),
                  Text(
                    weatherIcon,
                    style: kConditionTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
              ),
              child: Text(
                "$weatherMessage @ $cityName",
                textAlign: TextAlign.right,
                style: kMessageTextStyle,
              ),
            )
          ],
        )),
      ),
    );
  }
}
