import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather_data.dart';

// События
abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;

  FetchWeatherEvent(this.cityName);
}

// Состояния
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherData weatherData;

  WeatherLoadedState(this.weatherData);
}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState(this.error);
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        print("FETCH WEATHER EVENET DATA TEST");
        final weatherData = await getWeatherData(event.cityName);
        emit(WeatherLoadedState(weatherData));
      } catch (e) {
        emit(WeatherErrorState('Failed to fetch weather data.'));
      }
    });
  }

  Future<WeatherData> getWeatherData(String cityName) async {
    final baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
    final apiKey = '28533ab575fac6ad3628532cc043a142';
    final encodedCity = Uri.encodeComponent(cityName);
    final url = '$baseUrl?q=$encodedCity&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final name = data['name'];
      final weatherDescription = data['weather'][0]['description'];
      final icon = data['weather'][0]['icon'];
      final currTemp = data['main']['temp'];
      final minTemp = data['main']['temp_min'];
      final maxTemp = data['main']['temp_max'];
      final humidity = data['main']['humidity'];

      print("GET WEATHER DATA TEST");

      return WeatherData(
        name: name,
        weatherDescription: weatherDescription,
        icon: icon,
        currTemp: currTemp,
        minTemp: minTemp,
        maxTemp: maxTemp,
        humidity: humidity,
      );
    } else {
      throw Exception(
          'Failed to fetch weather data. Status Code: ${response.statusCode}');
    }
  }
}
