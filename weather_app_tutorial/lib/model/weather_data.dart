class WeatherData {
  final String icon;
  final int temperature;
  final int chanceOfRain;

  WeatherData({
    required this.icon,
    required this.temperature,
    required this.chanceOfRain,
  });

  String get time => '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';
}
