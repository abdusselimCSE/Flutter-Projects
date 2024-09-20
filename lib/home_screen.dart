import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'constants.dart' as k;

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  bool isLoaded = false;
  String cityName = '';
  TextEditingController textEditingController = TextEditingController();

  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      backgroundColor: const Color(0xFFE0AAFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildSearchBar(context),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weatherData?["city"] ?? "City not available",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Text(
                    //   weatherData?["country"] ?? "City not available",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    Text(
                      weatherData != null
                          ? "${weatherData!["temperature"]?.round().toString()}°C"
                          : "N/A",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (weatherData !=
                        null) // Ensure weatherData is available before displaying animation
                      Lottie.asset(
                        getWeatherAnimation(weatherData!["condition"]),
                        height: 200,
                        width: 200,
                      ),
                    Text(
                      weatherData?["description"] ?? "Condition not available",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Humidity Section
                    Column(
                      children: [
                        const Icon(
                          Icons.water_drop, // Humidity icon
                          size: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          weatherData != null
                              ? "${weatherData!["humidity"].toString()}%"
                              : "N/A",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "Humidity", // Label
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 40), // Space between the two sections

                    // Pressure Section
                    Column(
                      children: [
                        const Icon(
                          Icons.speed,
                          size: 30,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          weatherData != null
                              ? "${weatherData!["pressure"].toString()}hPa"
                              : "N/A",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "Pressure",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: IconButton(
            onPressed: () {
              setState(() {
                getCurrentLocation();
              });
            },
            icon: const Icon(
              CupertinoIcons.location_solid,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
      ],
      backgroundColor: const Color(0xFFE0AAFF),
      elevation: 5,
      title: const Text(
        "Weather App",
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: TextField(
        onSubmitted: (String city) {
          setState(() {
            cityName = city;
            isLoaded = false; // Reset loading state
            textEditingController.clear();
          });
          getCurrentCityWeather(cityName);
        },
        controller: textEditingController,
        cursorColor: Colors.white,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: 'City name',
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            size: 30,
            color: Colors.white.withOpacity(0.7),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> getCurrentCityWeather(String cityname) async {
    var client = http.Client();
    var uri =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=${k.apiKey}&units=metric';
    var url = Uri.parse(uri);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      print(decodeData);
      setState(
        () {
          isLoaded = true;
          weatherData = {
            'temperature': decodeData['main']['temp'],
            'pressure': decodeData['main']['pressure'],
            'humidity': decodeData['main']['humidity'],
            'city': decodeData['name'],
            'country': decodeData['sys']['country'],
            'condition': decodeData['weather'][0]['main'],
            'description': decodeData['weather'][0]['description'],
            'icon': decodeData['weather'][0]['icon']
          };
        },
      );
    } else {
      print('Failed to load weather data: ${response.statusCode}');
    }
  }

  String getWeatherAnimation(String? condition) {
    if (condition == null) return "assets/weather/sunny.json";

    switch (weatherData!["condition"].toString().toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/weather/cloud.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return "assets/weather/rainy.json";
      case 'thunderstorm':
        return "assets/weather/storm.json";
      case 'clear':
      case 'clear sky':
        return "assets/weather/sunny.json";
      default:
        return "assets/weather/sunny.json";
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark geoCity = placemarks[0];
      print(geoCity.locality);

      getCurrentCityWeather(geoCity.locality.toString());

      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
