import 'package:flutter/material.dart';

class WeatherProvider extends ChangeNotifier {
  bool isLoading = false;
  WeatherModel? weather;
  List<WeatherModel> forecast = []; // 🔹 এই লাইনটা নতুন যোগ করো

  Future<void> getWeather(String city) async {
    isLoading = true;
    notifyListeners();

    try {
      // এখানে তোমার আসল API কল থাকবে
      await Future.delayed(const Duration(seconds: 2));

      // বর্তমান আবহাওয়া
      weather = WeatherModel(
        city: city,
        tempC: 28,
        condition: "Sunny",
        icon: "https://cdn-icons-png.flaticon.com/512/869/869869.png",
        humidity: 60,
        windKph: 15,
        localTime: "2025-11-01 08:00",
      );

      // 🔹 ডেমো ডেটা হিসেবে Forecast যোগ করা হলো
      forecast = [
        WeatherModel(
          city: city,
          tempC: 27,
          condition: "Cloudy",
          icon: "https://cdn-icons-png.flaticon.com/512/414/414825.png",
          humidity: 58,
          windKph: 10,
          localTime: "2025-11-01 11:00",
        ),
        WeatherModel(
          city: city,
          tempC: 29,
          condition: "Rainy",
          icon: "https://cdn-icons-png.flaticon.com/512/1163/1163624.png",
          humidity: 70,
          windKph: 12,
          localTime: "2025-11-01 14:00",
        ),
      ];
    } catch (e) {
      weather = null;
      forecast = [];
    }

    isLoading = false;
    notifyListeners();
  }
}

class WeatherModel {
  final String city;
  final double tempC;
  final String condition;
  final String icon;
  final int humidity;
  final double windKph;
  final String localTime;

  // 🔹 এগুলো নতুন যোগ করো:
  final String? date;
  final String? conditionText;

  WeatherModel({
    required this.city,
    required this.tempC,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windKph,
    required this.localTime,
    this.date,
    this.conditionText,
  });
}

