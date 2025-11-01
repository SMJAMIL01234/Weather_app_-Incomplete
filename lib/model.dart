class WeatherModel {
  final double tempC;
  final double feelsLike;
  final double windKph;
  final int humidity;
  final double visibility;
  final double pressure;
  final double uv;
  final String description;
  final String icon;
  final String localTime;

  WeatherModel({
    required this.tempC,
    required this.feelsLike,
    required this.windKph,
    required this.humidity,
    required this.visibility,
    required this.pressure,
    required this.uv,
    required this.description,
    required this.icon,
    required this.localTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      tempC: json['current']['temp_c'].toDouble(),
      feelsLike: json['current']['feelslike_c'].toDouble(),
      windKph: json['current']['wind_kph'].toDouble(),
      humidity: json['current']['humidity'],
      visibility: json['current']['vis_km'].toDouble(),
      pressure: json['current']['pressure_mb'].toDouble(),
      uv: json['current']['uv'].toDouble(),
      description: json['current']['condition']['text'],
      icon: "https:${json['current']['condition']['icon']}",
      localTime: json['location']['localtime'],
    );
  }

  get condition => null;
}

class ForecastDay {
  final String date;
  final double tempC;
  final double windKph;
  final int humidity;
  final String conditionText;
  final String icon;

  ForecastDay({
    required this.date,
    required this.tempC,
    required this.windKph,
    required this.humidity,
    required this.conditionText,
    required this.icon,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      tempC: json['day']['avgtemp_c'].toDouble(),
      windKph: json['day']['maxwind_kph'].toDouble(),
      humidity: json['day']['avghumidity'],
      conditionText: json['day']['condition']['text'],
      icon: "https:${json['day']['condition']['icon']}",
    );
  }
}