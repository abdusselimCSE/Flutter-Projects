class WeatherInfo {
  double temperature;
  int pressure;
  int humidity;
  String city;
  String country;
  Map<String, dynamic>? weatherData;

  WeatherInfo({
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.city,
    required this.country,
  });
}
