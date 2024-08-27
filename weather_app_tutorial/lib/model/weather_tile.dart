import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherTile({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: Colors.blueGrey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                weatherData['time'],
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5),
              Image.network(weatherData['icon'], width: 50, height: 50),
              SizedBox(height: 5),
              Text(
                '${weatherData['temperature']}°',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                '${weatherData['chanceOfRain']}%',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
