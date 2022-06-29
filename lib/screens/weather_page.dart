import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:su_chat_hakan/models//weather_model.dart';
import 'dart:convert';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather() async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Konya&appid=dbc5e350fe6a203d1a99eff9175a5e4b&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    Weather weather = Weather.fromJson(body);
    return Weather.fromJson(body);
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color(0xffFFC107),
        title: const Text('Hava Durumu'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/manzara.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Text(
                        "${data?.main}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        '${data?.temp}°C',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60.0,
                            letterSpacing: -4),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "${data?.cityName}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            letterSpacing: -3),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
