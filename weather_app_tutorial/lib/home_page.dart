// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_tutorial/component/color.dart';
import 'package:weather_app_tutorial/component/text.dart';
import 'dart:convert';
import 'consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _weatherData = [];
  bool _loading = true;
  final TextEditingController _cityController = TextEditingController();

  @override
  // void initState() {
  //   super.initState();
  //   fetchWeather('Sihanoukville');
  // }
  void initState() {
    super.initState();
    fetchWeather([
      'Siem Reap',
      'Phnom Penh',
      'sihanoukville',
      'Tokyo',
      'Seoul',
      'Taipei',
      'Singapore',
      'London',
      'Hanoi',
      'Hong Kong',
      'Paris',
      'Beijing',
      'Bangkok',
    ]);
  }

  Future<void> fetchWeather(List cities) async {
    setState(() {
      _loading = true;
    });
    for (var city in cities) {
      final response =
          await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey'));
      if (response.statusCode == 200) {
        setState(() {
          _weatherData.add(json.decode(response.body));
          _loading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 4, 34, 58), // Start color
              const Color.fromARGB(255, 88, 153, 165), // End color
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : WeatherDisplay(weatherData: _weatherData),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final List weatherData;

  const WeatherDisplay({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          String iconCode = weatherData[index]['weather'][0]['icon'];
          String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';
          return GestureDetector(
            child: Card(
              color: Colors.blueGrey.withOpacity(0.7),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weatherData[index]['name']}',
                      style: Lora.textStyle,
                    ),
                    BuildWeatherInfoRow('Temperature',
                        '${(weatherData[index]['main']['temp'] - 273.15).toStringAsFixed(1)}°C'),
                    BuildWeatherInfoRow('Feels Like',
                        '${(weatherData[index]['main']['feels_like'] - 273.15).toStringAsFixed(1)}°C'),
                    BuildWeatherInfoRow('Weather',
                        '${weatherData[index]['weather'][0]['description']}'),
                    BuildWeatherInfoRow(
                        'Humidity', '${weatherData[index]['main']['humidity']}%'),
                    BuildWeatherInfoRow('Pressure',
                        '${weatherData[index]['main']['pressure']} hPa'),
                    BuildWeatherInfoRow('Wind Speed',
                        '${weatherData[index]['wind']['speed']} m/s'),
                    BuildWeatherInfoRow('Wind Direction',
                        '${weatherData[index]['wind']['deg']}°'),
                    const SizedBox(height: 10),
                    Image.network(iconUrl),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget BuildWeatherInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
