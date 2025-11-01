import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/next_page.dart';
import 'package:untitled6/theme_provider.dart';
import 'package:untitled6/weather_provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController cityController = TextEditingController();

  final List<Map<String, dynamic>> forecastData = [
    {
      "icon": "assets/images/sunny.png",
      "time": "08:00 AM",
      "temp": 28,
    },
    {
      "icon": "assets/images/sunny.png",
      "time": "11:00 AM",
      "temp": 30,
    },
    {
      "icon": "assets/images/thunder.png",
      "time": "02:00 PM",
      "temp": 29,
    },
    {
      "icon": "assets/images/snow.png",
      "time": "05:00 PM",
      "temp": 27,
    },
    {
      "icon": "assets/images/rainy.png",
      "time": "08:00 PM",
      "temp": 26,
    },
  ];

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final weather = weatherProvider.weather;

    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.grid_view),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDark ? Icons.wb_sunny : Icons.nightlight_round,
              color: themeProvider.isDark ? Colors.yellow : Colors.blueGrey,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🔹 Search Field
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cityController,
                      decoration: const InputDecoration(
                        hintText: "Enter City Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (cityController.text.trim().isNotEmpty) {
                          weatherProvider.getWeather(cityController.text.trim());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: weatherProvider.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.cyan,
                              ),
                            )
                          : const Text("Search"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// 🔹 Weather Display
              if (weather != null) ...[
                Text(
                  cityController.text.isEmpty
                      ? "City Name"
                      : cityController.text,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  weather.localTime?.split(" ").first ?? "",
                  style: const TextStyle(fontSize: 20, color: Colors.indigoAccent),
                ),
                const SizedBox(height: 20),

                /// 🔹 Weather Icon
                Center(
                  child: Image.network(
                    weather.icon ?? "",
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 80),
                  ),
                ),

                const SizedBox(height: 10),

                /// 🔹 Temperature and Condition
                Column(
                  children: [
                    Text(
                      "${weather.tempC} °C",
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      weather.condition ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// 🔹 Temp/Wind/Humidity Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWeatherInfo("Temp", "${weather.tempC} °C"),
                    _buildWeatherInfo("Wind", "${weather.windKph} KM/H"),
                    _buildWeatherInfo("Humidity", "${weather.humidity} %"),
                  ],
                ),

                const SizedBox(height: 20),

                /// 🔹 Forecast Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NextPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "View Full Report",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigoAccent,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                /// 🔹 Forecast Data Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(forecastData.length, (index) {
                    final item = forecastData[index];
                    return Column(
                      children: [
                        Image.asset(
                          item["icon"],
                          height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item["time"],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "${item["temp"]} °C",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ] else ...[
                const SizedBox(height: 100),
                const Text(
                  "Search for a city to see the weather ☀️",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Helper Widget for Info Box
  Widget _buildWeatherInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
