class Weather {
  String? cityName;
  String? main;
  double? temp;

  Weather({
    this.cityName,
    this.temp,
    this.main,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json['weather'][0]['main'],
      cityName: json['name'],
      temp: json['main']['temp'],
    );
  }
}
