import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'WeatherData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherWidget(),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WeatherState();
  }
}

class WeatherState extends State<WeatherWidget> {
  WeatherData weather = WeatherData.empty();

  WeatherState() {
    _getWeather();
  }

  void _getWeather() async {
    WeatherData data = await _fetchWeather();
    setState(() {
      weather = data;
    });
  }

  Future<WeatherData> _fetchWeather() async {
    final response = await http.get(
        'http://v.juhe.cn/weather/index?cityname=%E4%B8%8A%E6%B5%B7&dtype=&format=&key=4385e9b5a0c64d516a4b9a2c0ae9c667');
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      return WeatherData.empty();
    }
  }

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
                child: new Text(
                  "上海市",
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Colors.white, fontSize: 40.0),
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
