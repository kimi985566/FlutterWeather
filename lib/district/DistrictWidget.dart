import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast/district/DistrictData.dart';
import 'package:flutter_weather_forecast/weather/WeatherWidget.dart';
import 'package:http/http.dart' as http;

class DistrictWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DistrictState();
  }
}

class DistrictState extends State<DistrictWidget> {
  List<DistrictData> districtList = new List<DistrictData>();

  DistrictState() {
    _getCityList();
  }

  void _getCityList() async {
    List<DistrictData> districtListData = await _fetchCityList();
    setState(() {
      districtList = districtListData;
    });
  }

  //拉取城市列表
  Future<List<DistrictData>> _fetchCityList() async {
    final response = await http.get(
        'http://v.juhe.cn/weather/citys?key=4385e9b5a0c64d516a4b9a2c0ae9c667');

    List<DistrictData> districtList = new List<DistrictData>();

    if (response.statusCode == 200) {
      //解析数据
      Map<String, dynamic> result = json.decode(response.body);
      for (dynamic data in result['result']) {
        DistrictData cityData = DistrictData(data['district']);
        districtList.add(cityData);
      }
      return districtList;
    } else {
      return districtList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("选择区域"),
        ),
        body: ListView.builder(
            itemCount: districtList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: GestureDetector(
                  child: Text(districtList[index].districtName),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherWidget(
                                districtList[index].districtName)));
                  },
                ),
              );
            }));
  }
}
