class WeatherData {
  String weather;
  String temperature;
  String humidity;
  String time;

  WeatherData({this.weather, this.temperature, this.humidity, this.time});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        weather: json['result']['today']['weather'],
        temperature: json['result']['sk']['temp'] + "℃",
        humidity: "湿度  " + json['result']['sk']['humidity'],
        time: "更新时间  " + json['result']['sk']['time']);
  }

  factory WeatherData.empty() {
    return WeatherData(
      weather: "",
      temperature: "",
      humidity: "",
      time: "",
    );
  }
}
