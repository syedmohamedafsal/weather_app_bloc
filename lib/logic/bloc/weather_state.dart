import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherState {}

final class WeatherBlocLoading extends WeatherState {}

final class WeatherBlocFailure extends WeatherState {}

final class WeatherBlocSuccess extends WeatherState {
  final Weather weather;
  final List<Weather> hourlyForecast;

  const WeatherBlocSuccess(this.weather, this.hourlyForecast);
  @override
  List<Object> get props => [weather];
}
