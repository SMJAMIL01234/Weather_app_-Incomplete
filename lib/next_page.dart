import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/weather_provider.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.weather;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // Tomorrow section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(
                    weather?.icon ?? '', // null-safe
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tomorrow",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weather?.conditionText ?? "Unknown", // null-safe
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "${weather?.tempC ?? 0} °C", // null-safe
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Temp, Wind, Humidity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("Temp", style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
                      const SizedBox(height: 5),
                      Text("${weather?.tempC ?? 0} °C",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Wind", style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
                      const SizedBox(height: 5),
                      Text("${weather?.windKph ?? 0} KM/H",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Humidity", style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
                      const SizedBox(height: 5),
                      Text("${weather?.humidity ?? 0} %",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // In 5 Days Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "In 5 Days",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: weatherProvider.forecast.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: weatherProvider.forecast.length,
                        itemBuilder: (context, index) {
                          final item = weatherProvider.forecast[index];

                          // Null-safe weekday calculation
                          final weekdayIndex = item.date != null
                              ? DateTime.tryParse(item.date!)?.weekday ?? 0
                              : 0;
                          final dayName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                              [weekdayIndex > 0 ? weekdayIndex - 1 : 0];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(dayName,
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                                Image.network(item.icon ?? '', height: 40, width: 40),
                                Text(item.conditionText ?? "Unknown",
                                    style: const TextStyle(fontSize: 16)),
                                Text("${item.tempC?.toStringAsFixed(0) ?? 0}°C",
                                    style: const TextStyle(fontSize: 16)),
                                Text("${item.windKph?.toStringAsFixed(0) ?? 0} km/h",
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
