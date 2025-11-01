import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled6/model.dart';
 

class WeatherService {
  final String apiKey = "72e7e4f689134be0b3640336252309";

  Future<WeatherModel?> fetchWeather(String city) async {
    try {
      final url = "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<List<ForecastDay>> fetchForecast(String city) async {
    try {
      final url = "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=5";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List forecastList = data['forecast']['forecastday'];
        return forecastList.map((e) => ForecastDay.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error: $e");
    }
    return [];
  }
}