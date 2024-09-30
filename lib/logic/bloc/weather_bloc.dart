import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_bloc/logic/bloc/weather_event.dart';
import 'package:weather_app_bloc/logic/bloc/weather_state.dart';
import 'package:weather_app_bloc/logic/data/data.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FeatchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(ApiKey, language: Language.ENGLISH);

        // Fetch current weather
        Weather currentWeather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);

        // Fetch the hourly forecast (5-day forecast typically contains hourly data)
        List<Weather> forecast = await wf.fiveDayForecastByLocation(
            event.position.latitude, event.position.longitude);

        // Only take the next hour forecast
        List<Weather> nextHourlyForecast =
            forecast.take(5).toList(); // Adjust as necessary

        // Emit success state with current weather and hourly forecast
        emit(WeatherBlocSuccess(currentWeather, nextHourlyForecast));

        // Set up periodic updates every 1 hour
        Timer.periodic(const Duration(hours: 1), (timer) async {
          // Re-fetch both current weather and forecast
          Weather updatedWeather = await wf.currentWeatherByLocation(
              event.position.latitude, event.position.longitude);
          List<Weather> updatedForecast = await wf.fiveDayForecastByLocation(
            event.position.latitude,
            event.position.longitude,
          );

          // Only take the next hour forecast
          List<Weather> updatedNextHourlyForecast =
              updatedForecast.take(5).toList(); // Adjust as necessary

          // Emit new success state with updated weather
          emit(WeatherBlocSuccess(updatedWeather, updatedNextHourlyForecast));
        });
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
