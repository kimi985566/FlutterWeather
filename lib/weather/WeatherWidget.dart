import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast/district/DistrictWidget.dart';
import 'package:flutter_weather_forecast/weather/WeatherData.dart';
import 'package:http/http.dart' as http;

class WeatherWidget extends StatefulWidget {
  String districtName;

  WeatherWidget(this.districtName);

  @override
  State<StatefulWidget> createState() {
    return new WeatherState(this.districtName);
  }
}

class WeatherState extends State<WeatherWidget> {
  String districtName;
  WeatherData weather = WeatherData.empty();

  WeatherState(String districtName) {
    this.districtName = districtName;
    _getWeather();
  }

  void _getWeather() async {
    WeatherData data = await _fetchWeather();
    setState(() {
      weather = data;
    });
  }

  Future<WeatherData> _fetchWeather() async {
    final response = await http.get('http://v.juhe.cn/weather/index?cityname=' +
        this.districtName +
        '&dtype=&format=&key=4385e9b5a0c64d516a4b9a2c0ae9c667');
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      return WeatherData.empty();
    }
  }

  Future<bool> _onWillPop()=>new Future.value(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.asset(
            "images/weather_bg.jpg",
            fit: BoxFit.fitHeight,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0),
                child: new GestureDetector(
                  child: new Text(
                    this.districtName,
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DistrictWidget()));
                  },
                ),
              ),
              new Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 100.0),
                child: new Column(
                  children: <Widget>[
                    new Text(weather?.weather,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 55.0)),
                    new Text(weather?.temperature,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 50.0)),
                    new Text(
                      weather?.humidity,
                      style: new TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    new Text(
                      weather?.time,
                      style: new TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
