import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final DateTime time;
  final String temperature;
  final String iconUrl;
  final String chanceOfRain;

  const WeatherCard({
    Key? key,
    required this.time,
    required this.temperature,
    required this.iconUrl,
    required this.chanceOfRain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${time.hour}:00', style: TextStyle(color: Colors.white)),
        Image.network(iconUrl, width: 50, height: 50),
        Text(temperature, style: TextStyle(color: Colors.white)),
        Text(chanceOfRain, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
